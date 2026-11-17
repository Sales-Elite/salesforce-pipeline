@isTest
private class MCPN_OrderSignalTest {
    @isTest static void critical() {
        Account a = new Account(Name = 'Sig Test');
        insert a;
        Test.startTest();
        Database.SaveResult sr = MCPN_OrderSignalPublisher.publish(a.Id, 'CRITICAL', 'Boom');
        Test.getEventBus().deliver();
        Test.stopTest();
        System.assert(sr.isSuccess(), 'publish should succeed');
        List<Task> ts = [SELECT Subject, Description, Priority FROM Task WHERE WhatId = :a.Id];
        System.assertEquals(1, ts.size(), 'one task');
        System.assertEquals('High', ts[0].Priority, 'priority high');
        System.assertEquals('Order signal: CRITICAL', ts[0].Subject, 'subject');
        System.assertEquals('Boom', ts[0].Description, 'description');
    }
    @isTest static void minor() {
        Account a = new Account(Name = 'Sig Test');
        insert a;
        Test.startTest();
        MCPN_OrderSignalPublisher.publish(a.Id, 'minor', 'Small');
        Test.getEventBus().deliver();
        Test.stopTest();
        List<Task> ts = [SELECT Priority FROM Task WHERE WhatId = :a.Id];
        System.assertEquals(1, ts.size(), 'one task');
        System.assertEquals('Normal', ts[0].Priority, 'priority normal');
    }
    @isTest static void unknownAndInvalid() {
        Account a = new Account(Name = 'Sig Test');
        Account gone = new Account(Name = 'Sig Gone');
        insert new List<Account>{a, gone};
        String goneId = String.valueOf(gone.Id);
        delete gone;
        Test.startTest();
        MCPN_OrderSignalPublisher.publish(goneId, 'critical', 'x');
        MCPN_OrderSignalPublisher.publish('not-an-id', 'critical', 'x');
        MCPN_OrderSignalPublisher.publish('', 'critical', 'x');
        MCPN_OrderSignalPublisher.publish(a.Id, 'minor', 'ok');
        Test.getEventBus().deliver();
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Task WHERE WhatId = :a.Id], 'only valid one');
        System.assertEquals(1, [SELECT count() FROM Task WHERE Subject LIKE 'Order signal:%'], 'no others');
    }
    @isTest static void manyEvents() {
        Account a = new Account(Name = 'Sig Test');
        insert a;
        List<MCPN_Order_Signal__e> evts = new List<MCPN_Order_Signal__e>();
        for (Integer i = 0; i < 200; i++) {
            evts.add(new MCPN_Order_Signal__e(Account_Id__c = a.Id, Severity__c = 'critical', Message__c = 'm' + i));
        }
        Test.startTest();
        EventBus.publish(evts);
        Test.getEventBus().deliver();
        Test.stopTest();
        System.assertEquals(200, [SELECT count() FROM Task WHERE WhatId = :a.Id], '200 tasks');
    }
}