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

    private static void runBatch(User csmUser) {
        System.runAs(csmUser) {
            Test.startTest();
            Database.executeBatch(new RenewalRiskScoringBatch(), 200);
            Test.stopTest();
        }
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

        runBatch(csmUser);

        Map<Id, Renewal__c> byId = new Map<Id, Renewal__c>(
            [SELECT Id, Account__c, Risk_Level__c FROM Renewal__c]);
        for (Renewal__c r : byId.values()) {
            if (r.Id == closedRenewal.Id) {
                Assert.areEqual(null, r.Risk_Level__c, 'Closed renewal untouched');
            } else if (r.Account__c == high.Id) {
                Assert.areEqual('High', r.Risk_Level__c, '2 open high cases => High');
            } else if (r.Account__c == med.Id) {
                Assert.areEqual('Medium', r.Risk_Level__c, '1 open high case => Medium');
            } else if (r.Account__c == low.Id) {
                Assert.areEqual('Low', r.Risk_Level__c, 'Recent activity, no open high cases => Low');
            } else if (r.Account__c == oppOnly.Id) {
                Assert.areEqual('High', r.Risk_Level__c, 'Opportunity activity not counted => High');
            }
        }
    }

    @isTest
    static void testCalculateRiskLevel() {
        User csmUser = createCsmUser();
        System.runAs(csmUser) {
            Assert.areEqual('High', RenewalRiskScoringBatch.calculateRiskLevel(2, 0), '2 cases');
            Assert.areEqual('High', RenewalRiskScoringBatch.calculateRiskLevel(3, 0), '3 cases');
            Assert.areEqual('Medium', RenewalRiskScoringBatch.calculateRiskLevel(1, 0), '1 case');
            Assert.areEqual('Low', RenewalRiskScoringBatch.calculateRiskLevel(0, 0), '0 cases');
            Assert.areEqual('Low', RenewalRiskScoringBatch.calculateRiskLevel(null, 0), 'null cases treated as 0');
            Assert.areEqual('High', RenewalRiskScoringBatch.calculateRiskLevel(0, 61), '61 days');
            Assert.areEqual('Medium', RenewalRiskScoringBatch.calculateRiskLevel(0, 60), '60 days');
            Assert.areEqual('Medium', RenewalRiskScoringBatch.calculateRiskLevel(0, 31), '31 days');
            Assert.areEqual('Low', RenewalRiskScoringBatch.calculateRiskLevel(0, 30), '30 days');
            Assert.areEqual('Low', RenewalRiskScoringBatch.calculateRiskLevel(0, 5), '5 days');
            Assert.areEqual('High', RenewalRiskScoringBatch.calculateRiskLevel(0, null), 'no activity');
            Assert.areEqual('High', RenewalRiskScoringBatch.calculateRiskLevel(null, null), 'nothing at all');
        }
    }

    @isTest
    static void testUnchangedLevelNotUpdated() {
        User csmUser = createCsmUser();
        Account acc = new Account(Name = 'Unchanged Acc', OwnerId = csmUser.Id);
        insert acc;
        Renewal__c r = new Renewal__c(Account__c = acc.Id, Renewal_Date__c = Date.today().addDays(90));
        insert r;
        insert new Task(WhatId = acc.Id, Subject = 'x', Status = 'Completed',
                        ActivityDate = Date.today(), OwnerId = csmUser.Id);

        runBatch(csmUser);
        Renewal__c after1 = [SELECT Risk_Level__c, LastModifiedDate, SystemModstamp FROM Renewal__c WHERE Id = :r.Id];
        Assert.areEqual('Low', after1.Risk_Level__c, 'First run sets Low');

        // Second pass (direct execute): level already holds the computed value, so no update is made.
        System.runAs(csmUser) {
            new RenewalRiskScoringBatch().execute(null, new List<Account>{ acc });
        }
        Renewal__c after2 = [SELECT Risk_Level__c, LastModifiedDate, SystemModstamp FROM Renewal__c WHERE Id = :r.Id];
        Assert.areEqual('Low', after2.Risk_Level__c, 'Level unchanged on second run');
        Assert.areEqual(after1.SystemModstamp, after2.SystemModstamp, 'Record not updated again');
    }

    @isTest
    static void testEventOnlyAccount() {
        User csmUser = createCsmUser();
        Account acc = new Account(Name = 'Event Only Acc', OwnerId = csmUser.Id);
        insert acc;
        Renewal__c r = new Renewal__c(Account__c = acc.Id, Renewal_Date__c = Date.today().addDays(90));
        insert r;
        insert new Event(WhatId = acc.Id, Subject = 'e', ActivityDateTime = System.now().addDays(-2),
                         DurationInMinutes = 30, OwnerId = csmUser.Id);

        runBatch(csmUser);
        Assert.areEqual('Low', [SELECT Risk_Level__c FROM Renewal__c WHERE Id = :r.Id].Risk_Level__c,
            'Recent past Event alone counts as activity => Low');
    }

    @isTest
    static void testClosedTaskWithoutActivityDateUsesCreatedDate() {
        User csmUser = createCsmUser();
        Account acc = new Account(Name = 'No Date Task Acc', OwnerId = csmUser.Id);
        insert acc;
        Renewal__c r = new Renewal__c(Account__c = acc.Id, Renewal_Date__c = Date.today().addDays(90));
        insert r;
        insert new Task(WhatId = acc.Id, Subject = 'x', Status = 'Completed', OwnerId = csmUser.Id);

        runBatch(csmUser);
        Assert.areEqual('Low', [SELECT Risk_Level__c FROM Renewal__c WHERE Id = :r.Id].Risk_Level__c,
            'Task CreatedDate (today) used when ActivityDate blank => Low');
    }

    @isTest
    static void testRenewedAndChurnedUntouched() {
        User csmUser = createCsmUser();
        Account acc = new Account(Name = 'Closed Only Acc', OwnerId = csmUser.Id);
        insert acc;
        Renewal__c renewed = new Renewal__c(Account__c = acc.Id,
            Renewal_Date__c = Date.today().addDays(90), Status__c = 'Renewed');
        insert renewed;
        Renewal__c churned = new Renewal__c(Account__c = acc.Id,
            Renewal_Date__c = Date.today().addDays(90), Status__c = 'Churned');
        insert churned;

        runBatch(csmUser);
        Assert.areEqual(null, [SELECT Risk_Level__c FROM Renewal__c WHERE Id = :renewed.Id].Risk_Level__c,
            'Renewed renewal is not changed');
        Assert.areEqual(null, [SELECT Risk_Level__c FROM Renewal__c WHERE Id = :churned.Id].Risk_Level__c,
            'Churned renewal is not changed');
    }

    @isTest
    static void testManualRiskLevelKept() {
        User csmUser = createCsmUser();
        Account acc = new Account(Name = 'Manual Acc', OwnerId = csmUser.Id);
        insert acc;
        // No activity at all => calculated High; manual flag must keep Low.
        Renewal__c manual = new Renewal__c(Account__c = acc.Id, Renewal_Date__c = Date.today().addDays(90),
            Risk_Level__c = 'Low', Risk_Level_Set_Manually__c = true);
        insert manual;

        runBatch(csmUser);
        Assert.areEqual('Low', [SELECT Risk_Level__c FROM Renewal__c WHERE Id = :manual.Id].Risk_Level__c,
            'Manually set Risk Level is kept');
    }

    @isTest
    static void testPartialFailureReported() {
        User csmUser = createCsmUser();
        Account acc = new Account(Name = 'Fail Acc', OwnerId = csmUser.Id);
        insert acc;
        Renewal__c good = new Renewal__c(Account__c = acc.Id, Renewal_Date__c = Date.today().addDays(90));
        Renewal__c gone = new Renewal__c(Account__c = acc.Id, Renewal_Date__c = Date.today().addDays(90));
        insert new List<Renewal__c>{ good, gone };
        Id goneId = gone.Id;
        delete gone;

        System.runAs(csmUser) {
            RenewalRiskScoringBatch b = new RenewalRiskScoringBatch();
            b.applyUpdates(new List<Renewal__c>{
                new Renewal__c(Id = goneId, Risk_Level__c = 'High'),
                new Renewal__c(Id = good.Id, Risk_Level__c = 'High')
            });
            Assert.areEqual(1, b.failures.size(), 'One failure recorded');
            Assert.isTrue(b.failures[0].contains(String.valueOf(goneId)), 'Failure names the renewal Id');

            Integer before = Limits.getEmailInvocations();
            b.sendFailureReport(null);
            Assert.areEqual(before, Limits.getEmailInvocations(), 'No email without recipient');
            b.sendFailureReport(csmUser.Email);
            Assert.areEqual(before + 1, Limits.getEmailInvocations(), 'Failure email sent');

            RenewalRiskScoringBatch clean = new RenewalRiskScoringBatch();
            clean.sendFailureReport(csmUser.Email);
            Assert.areEqual(before + 1, Limits.getEmailInvocations(), 'No email when nothing failed');
            clean.applyUpdates(null);
        }
        Assert.areEqual('High', [SELECT Risk_Level__c FROM Renewal__c WHERE Id = :good.Id].Risk_Level__c,
            'Other record still updated');
    }
}