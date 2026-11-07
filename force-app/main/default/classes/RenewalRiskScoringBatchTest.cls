@isTest
private class RenewalRiskScoringBatchTest {

    private static User createCsmUser() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Customer_Success_Manager' LIMIT 1];
        String uniq = String.valueOf(System.currentTimeMillis());
        User u = new User(
            ProfileId = p.Id,
            Username = 'csm.' + uniq + '@northstar.test',
            Email = 'csm.' + uniq + '@northstar.test',
            LastName = 'CsmTest',
            Alias = 'csmt',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        System.runAs(new User(Id = UserInfo.getUserId())) {
            insert u;
            insert new PermissionSetAssignment(AssigneeId = u.Id, PermissionSetId = ps.Id);
        }
        return u;
    }

    private static Case mkCase(Id accId, String priority, String status, Id ownerId) {
        Case c = new Case(AccountId = accId, Priority = priority, Status = status,
                          Origin = 'Web', Subject = 'T', Onboarding_Tier__c = 'Gold', OwnerId = ownerId);
        if (status == 'Closed') {
            c.Reason = 'New problem';
        }
        return c;
    }

    @isTest
    static void testBatchEndToEnd() {
        User csmUser = createCsmUser();
        Id ownerId = csmUser.Id;

        Account high = new Account(Name = 'High Acc', OwnerId = ownerId);
        Account med = new Account(Name = 'Med Acc', OwnerId = ownerId);
        Account low = new Account(Name = 'Low Acc', OwnerId = ownerId);
        Account oppOnly = new Account(Name = 'Opp Only Acc', OwnerId = ownerId);
        insert new List<Account>{ high, med, low, oppOnly };

        List<Renewal__c> renewals = new List<Renewal__c>();
        for (Account a : new List<Account>{ high, med, low, oppOnly }) {
            renewals.add(new Renewal__c(Account__c = a.Id, Renewal_Date__c = Date.today().addDays(90)));
        }
        Renewal__c closedRenewal = new Renewal__c(Account__c = low.Id,
            Renewal_Date__c = Date.today().addDays(90), Status__c = 'Renewed');
        renewals.add(closedRenewal);
        insert renewals;

        List<Case> cases = new List<Case>{
            mkCase(high.Id, 'High', 'New', ownerId), mkCase(high.Id, 'High', 'New', ownerId),
            mkCase(med.Id, 'High', 'New', ownerId), mkCase(med.Id, 'Medium', 'New', ownerId),
            mkCase(low.Id, 'Medium', 'New', ownerId)
        };
        insert cases;
        insert mkCase(low.Id, 'High', 'Closed', ownerId);

        insert new List<Task>{
            new Task(WhatId = high.Id, Subject = 'x', Status = 'Completed', ActivityDate = Date.today(), OwnerId = ownerId),
            new Task(WhatId = med.Id, Subject = 'x', Status = 'Completed', ActivityDate = Date.today(), OwnerId = ownerId),
            new Task(WhatId = low.Id, Subject = 'x', Status = 'Completed', OwnerId = ownerId)
        };
        insert new Event(WhatId = low.Id, Subject = 'e', ActivityDateTime = System.now().addDays(-1),
                         DurationInMinutes = 30, OwnerId = ownerId);

        Opportunity opp = new Opportunity(Name = 'O', AccountId = oppOnly.Id,
            StageName = 'Prospecting', CloseDate = Date.today().addDays(30), OwnerId = ownerId);
        insert opp;
        insert new Task(WhatId = opp.Id, Subject = 'x', Status = 'Completed', ActivityDate = Date.today(), OwnerId = ownerId);

        System.runAs(csmUser) {
            Test.startTest();
            Database.executeBatch(new RenewalRiskScoringBatch(), 200);
            Test.stopTest();
        }

        Map<Id, Renewal__c> byId = new Map<Id, Renewal__c>(
            [SELECT Id, Account__c, Risk_Level__c FROM Renewal__c]);
        for (Renewal__c r : byId.values()) {
            if (r.Id == closedRenewal.Id) {
                System.assertEquals(null, r.Risk_Level__c, 'Closed renewal untouched');
            } else if (r.Account__c == high.Id) {
                System.assertEquals('High', r.Risk_Level__c, '2 open high cases => High');
            } else if (r.Account__c == med.Id) {
                System.assertEquals('Medium', r.Risk_Level__c, '1 open high case => Medium');
            } else if (r.Account__c == low.Id) {
                System.assertEquals('Low', r.Risk_Level__c, 'Recent activity, no open high cases => Low');
            } else if (r.Account__c == oppOnly.Id) {
                System.assertEquals('High', r.Risk_Level__c, 'Opportunity activity not counted => High');
            }
        }
    }

    @isTest
    static void testCalculateRiskLevel() {
        User csmUser = createCsmUser();
        System.runAs(csmUser) {
            System.assertEquals('High', RenewalRiskScoringBatch.calculateRiskLevel(2, 0), '2 cases');
            System.assertEquals('Medium', RenewalRiskScoringBatch.calculateRiskLevel(1, 0), '1 case');
            System.assertEquals('High', RenewalRiskScoringBatch.calculateRiskLevel(0, 61), '61 days');
            System.assertEquals('Medium', RenewalRiskScoringBatch.calculateRiskLevel(0, 60), '60 days');
            System.assertEquals('Medium', RenewalRiskScoringBatch.calculateRiskLevel(0, 31), '31 days');
            System.assertEquals('Low', RenewalRiskScoringBatch.calculateRiskLevel(0, 30), '30 days');
            System.assertEquals('Low', RenewalRiskScoringBatch.calculateRiskLevel(0, 5), '5 days');
            System.assertEquals('High', RenewalRiskScoringBatch.calculateRiskLevel(0, null), 'no activity');
        }
    }
}