@isTest
private class AccountTriggerHandlerTest {
    @isTest static void hotSetsFlag() {
        Account a = new Account(Name = 'T Hot', Rating = 'Hot');
        insert a;
        a = [SELECT LT2_Flag__c FROM Account WHERE Id = :a.Id];
        System.assertEquals(true, a.LT2_Flag__c, 'Hot should set flag');
    }
    @isTest static void coldNotFlag() {
        Account a = new Account(Name = 'T Cold', Rating = 'Cold');
        insert a;
        a = [SELECT LT2_Flag__c FROM Account WHERE Id = :a.Id];
        System.assertEquals(false, a.LT2_Flag__c, 'Cold should not set flag');
    }
    @isTest static void updateClears() {
        Account a = new Account(Name = 'T Upd', Rating = 'Hot');
        insert a;
        a.Rating = 'Warm';
        update a;
        a = [SELECT LT2_Flag__c FROM Account WHERE Id = :a.Id];
        System.assertEquals(false, a.LT2_Flag__c, 'Warm should clear flag');
    }
    @isTest static void largeBatch() {
        List<Account> l = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            l.add(new Account(Name = 'Batch ' + i, Rating = 'Hot'));
        }
        insert l;
        System.assertEquals(200, [SELECT COUNT() FROM Account WHERE LT2_Flag__c = true AND Name LIKE 'Batch %'], 'All flagged');
    }
}