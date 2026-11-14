@isTest
private class LT13_AccountDescriptionJobTest {
    @isTest
    static void testBatch() {
        List<Account> accs = new List<Account>{
            new Account(Name = 'A1', Description = 'old'),
            new Account(Name = 'A2'),
            new Account(Name = 'A3', Description = 'checked')
        };
        insert accs;
        Test.startTest();
        Database.executeBatch(new LT13_AccountDescriptionJob(), 200);
        Test.stopTest();
        for (Account a : [SELECT Description FROM Account WHERE Id IN :accs]) {
            System.assertEquals('checked', a.Description, 'Description should be checked');
        }
    }

    @isTest
    static void testSchedule() {
        Test.startTest();
        Id jobId = System.schedule('LT13 test', LT13_AccountDescriptionJob.CRON_HOURLY, new LT13_AccountDescriptionJob());
        Test.stopTest();
        CronTrigger ct = [SELECT CronExpression FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals('0 0 * * * ?', ct.CronExpression, 'Cron should be hourly');
    }
}