@isTest
private class LT17A_LeadDescriptionJobTest {
    @isTest
    static void testBatch() {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'T' + i, Company = 'C' + i, Description = 'note ' + i));
        }
        insert leads;
        Test.startTest();
        Database.executeBatch(new LT17A_LeadDescriptionJob(), 200);
        Test.stopTest();
        Integer n = [SELECT COUNT() FROM Lead WHERE Id IN :leads AND IsConverted = false];
        System.assertEquals(200, n, 'All leads should exist');
        for (Lead l : [SELECT Description FROM Lead WHERE Id IN :leads]) {
            System.assertEquals('checked', l.Description, 'Description should be checked');
        }
    }

    @isTest
    static void testSchedule() {
        Test.startTest();
        String jobId = System.schedule('LT17A test sched', '0 0 * * * ?', new LT17A_LeadDescriptionJob());
        Test.stopTest();
        System.assertEquals(1, [SELECT COUNT() FROM CronTrigger WHERE Id = :jobId], 'Job should be scheduled');
    }
}