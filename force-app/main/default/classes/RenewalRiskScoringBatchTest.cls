@isTest
private class RenewalRiskScoringBatchTest {

    private static Case mkCase(Id accId, String priority, String status) {
        Case c = new Case(AccountId = accId, Priority = priority, Status = status,
                          Origin = 'Web', Subject = 'T', Onboarding_Tier__c = 'Gold');
        if (status == 'Closed') {
            c.Reason = 'New problem';
        }
        return c;
    }

    @isTest
    static void testBatchEndToEnd() {
        Account high = new Account(Name = 'High Acc');
        Account med = new Account(Name = 'Med Acc');
        Account low = new Account(Name = 'Low Acc');
        Account oppOnly = new Account(Name = 'Opp Only Acc');
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
            mkCase(high.Id, 'High', 'New'), mkCase(high.Id, 'High', 'New'),
            mkCase(med.Id, 'High', 'New'), mkCase(med.Id, 'Medium', 'New'),
            mkCase(low.Id, 'Medium', 'New')
        };
        insert cases;
        insert mkCase(low.Id, 'High', 'Closed');

        insert new List<Task>{
            new Task(WhatId = high.Id, Subject = 'x', Status = 'Completed', ActivityDate = Date.today()),
            new Task(WhatId = med.Id, Subject = 'x', Status = 'Completed', ActivityDate = Date.today()),
            new Task(WhatId = low.Id, Subject = 'x', Status = 'Completed')
        };
        insert new Event(WhatId = low.Id, Subject = 'e', ActivityDateTime = System.now().addDays(-1),
                         DurationInMinutes = 30);

        Opportunity opp = new Opportunity(Name = 'O', AccountId = oppOnly.Id,
            StageName = 'Prospecting', CloseDate = Date.today().addDays(30));
        insert opp;
        insert new Task(WhatId = opp.Id, Subject = 'x', Status = 'Completed', ActivityDate = Date.today());

        Test.startTest();
        Database.executeBatch(new RenewalRiskScoringBatch(), 200);
        Test.stopTest();

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