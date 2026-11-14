@isTest
private class LT15D_LeadCheckedJobTest {
    @isTest
    static void testSchedule() {
        Test.startTest();
        String jobId = System.schedule('LT15D test', LT15D_LeadCheckedJob.CRON_HOURLY, new LT15D_LeadCheckedJob());
        Test.stopTest();
        CronTrigger ct = [SELECT CronExpression FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals(LT15D_LeadCheckedJob.CRON_HOURLY, ct.CronExpression, 'Cron should match');
    }

    @isTest
    static void testBatchDirect() {
        insert new List<Lead>{
            new Lead(LastName = 'A', Company = 'T', Description = 'x'),
            new Lead(LastName = 'B', Company = 'T', Description = 'checked'),
            new Lead(LastName = 'C', Company = 'T')
        };
        Test.startTest();
        Database.executeBatch(new LT15D_LeadCheckedJob(), 200);
        Test.stopTest();
        for (Lead l : [SELECT Description FROM Lead]) {
            System.assertEquals('checked', l.Description, 'Description should be checked');
        }
    }
}