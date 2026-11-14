@isTest
private class RenewalRiskSchedulerTest {

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

    @isTest
    static void schedulesAndStartsBatch() {
        User csmUser = createCsmUser();
        Id jobId;
        System.runAs(csmUser) {
            Test.startTest();
            jobId = System.schedule('Test Renewal Risk', RenewalRiskScheduler.CRON_EXPR, new RenewalRiskScheduler());
            Test.stopTest();
        }
        CronTrigger ct = [SELECT CronExpression FROM CronTrigger WHERE Id = :jobId];
        Assert.areEqual('0 0 2 * * ?', ct.CronExpression, 'Cron should be 02:00 nightly');
    }

    @isTest
    static void executeQueuesBatch() {
        User csmUser = createCsmUser();
        Account acc = new Account(Name = 'Sched Acc', OwnerId = csmUser.Id);
        insert acc;
        Renewal__c r = new Renewal__c(Account__c = acc.Id, Renewal_Date__c = Date.today().addDays(90));
        insert r;
        System.runAs(csmUser) {
            Test.startTest();
            new RenewalRiskScheduler().execute(null);
            Test.stopTest();
        }
        Integer n = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND ApexClass.Name = 'RenewalRiskScoringBatch'];
        Assert.isTrue(n >= 1, 'Batch job should have been queued');
        Assert.isNotNull([SELECT Risk_Level__c FROM Renewal__c WHERE Id = :r.Id].Risk_Level__c,
            'Batch ran and set the risk level');
    }

    @isTest
    static void scheduleNightlyHelper() {
        User csmUser = createCsmUser();
        // Org may already have the real nightly job scheduled; clear it within the test transaction only.
        for (CronTrigger existing : [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = :RenewalRiskScheduler.JOB_NAME]) {
            System.abortJob(existing.Id);
        }
        Id jobId;
        System.runAs(csmUser) {
            Test.startTest();
            jobId = RenewalRiskScheduler.scheduleNightly();
            Test.stopTest();
        }
        Assert.isNotNull(jobId, 'Job id should be returned');
        CronTrigger ct = [SELECT CronExpression, CronJobDetail.Name FROM CronTrigger WHERE Id = :jobId];
        Assert.areEqual('0 0 2 * * ?', ct.CronExpression, 'Nightly cron');
        Assert.areEqual(RenewalRiskScheduler.JOB_NAME, ct.CronJobDetail.Name, 'Job name');
    }
}