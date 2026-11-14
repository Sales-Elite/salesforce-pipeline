@isTest
private class LT14_AccountDescriptionSchedulerTest {
    @isTest
    static void testBatchSetsChecked() {
        List<Account> accs = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accs.add(new Account(Name = 'LT14 Acc ' + i, Description = (i == 0 ? 'checked' : 'other ' + i)));
        }
        insert accs;
        Test.startTest();
        Database.executeBatch(new LT14_AccountDescriptionScheduler(), 200);
        Test.stopTest();
        for (Account a : [SELECT Id, Description FROM Account WHERE Id IN :accs]) {
            System.assertEquals('checked', a.Description, 'Description should be checked');
        }
    }

    @isTest
    static void testScheduleCreated() {
        Test.startTest();
        Id jobId = System.schedule('LT14 test', '0 0 * * * ?', new LT14_AccountDescriptionScheduler());
        Test.stopTest();
        CronTrigger ct = [SELECT CronExpression FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals('0 0 * * * ?', ct.CronExpression, 'Cron should be hourly');
    }
}