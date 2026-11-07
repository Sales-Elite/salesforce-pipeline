@isTest
private class RenewalRiskSchedulerTest {
    @isTest
    static void schedulesAndStartsBatch() {
        Test.startTest();
        Id jobId = System.schedule('Test Renewal Risk', RenewalRiskScheduler.CRON_EXPR, new RenewalRiskScheduler());
        Test.stopTest();
        CronTrigger ct = [SELECT CronExpression FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals('0 0 2 * * ?', ct.CronExpression, 'Cron should be 02:00 nightly');
    }

    @isTest
    static void executeQueuesBatch() {
        Test.startTest();
        new RenewalRiskScheduler().execute(null);
        Test.stopTest();
        Integer n = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND ApexClass.Name = 'RenewalRiskScoringBatch'];
        System.assert(n >= 1, 'Batch job should have been queued');
    }

    @isTest
    static void scheduleNightlyHelper() {
        // Org may already have the real nightly job scheduled; clear it within the test transaction only.
        for (CronTrigger existing : [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = :RenewalRiskScheduler.JOB_NAME]) {
            System.abortJob(existing.Id);
        }
        Test.startTest();
        Id jobId = RenewalRiskScheduler.scheduleNightly();
        Test.stopTest();
        System.assertNotEquals(null, jobId, 'Job id should be returned');
    }
}