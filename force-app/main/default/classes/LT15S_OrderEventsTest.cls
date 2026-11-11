@isTest
private class LT15S_OrderEventsTest {
    private static List<LT15S_Fulfilment__c> fulfilments(Set<Id> ids) {
        return [SELECT Id, LT15S_Order__c, LT15S_Type__c, LT15S_Status__c FROM LT15S_Fulfilment__c WHERE LT15S_Order__c IN :ids];
    }

    @isTest
    static void insertPublishesEventNoFulfilment() {
        Test.startTest();
        LT15S_Order__c o = new LT15S_Order__c(LT15S_Status__c = 'New', LT15S_Total__c = 10);
        insert o;
        Test.getEventBus().deliver();
        Test.stopTest();
        System.assertEquals(0, fulfilments(new Set<Id>{o.Id}).size(), 'New order must not create fulfilment');
    }

    @isTest
    static void paidCreatesOneFulfilmentAndNoDuplicate() {
        LT15S_Order__c o = new LT15S_Order__c(LT15S_Status__c = 'New', LT15S_Total__c = 10);
        insert o;
        Test.startTest();
        o.LT15S_Status__c = 'Paid';
        update o;
        Test.getEventBus().deliver();
        o.LT15S_Status__c = 'Shipped';
        update o;
        o.LT15S_Status__c = 'Paid';
        update o;
        Test.getEventBus().deliver();
        Test.stopTest();
        List<LT15S_Fulfilment__c> fs = fulfilments(new Set<Id>{o.Id});
        System.assertEquals(1, fs.size(), 'Exactly one fulfilment expected');
        System.assertEquals('Pick and pack', fs[0].LT15S_Type__c, 'Type');
        System.assertEquals('Open', fs[0].LT15S_Status__c, 'Status');
    }

    @isTest
    static void nonPaidAndNoChangeCreateNothing() {
        LT15S_Order__c o = new LT15S_Order__c(LT15S_Status__c = 'New', LT15S_Total__c = 10);
        insert o;
        Test.startTest();
        o.LT15S_Status__c = 'Shipped';
        update o;
        Test.getEventBus().deliver();
        o.LT15S_Total__c = 20;
        update o;
        Test.getEventBus().deliver();
        Test.stopTest();
        System.assertEquals(0, fulfilments(new Set<Id>{o.Id}).size(), 'No fulfilment for non-Paid');
    }

    @isTest
    static void invalidEventIdIgnored() {
        Test.startTest();
        EventBus.publish(new LT15S_Order_Event__e(LT15S_Order_Id__c = 'bogus', LT15S_New_Status__c = 'Paid'));
        EventBus.publish(new LT15S_Order_Event__e(LT15S_Order_Id__c = null, LT15S_New_Status__c = 'Paid'));
        Test.getEventBus().deliver();
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM LT15S_Fulfilment__c], 'No fulfilment for invalid ids');
    }

    @isTest
    static void bulkUpdateTo200() {
        List<LT15S_Order__c> orders = new List<LT15S_Order__c>();
        for (Integer i = 0; i < 200; i++) {
            orders.add(new LT15S_Order__c(LT15S_Status__c = 'New', LT15S_Total__c = i));
        }
        insert orders;
        Test.startTest();
        for (LT15S_Order__c o : orders) {
            o.LT15S_Status__c = 'Paid';
        }
        update orders;
        Test.getEventBus().deliver();
        Test.stopTest();
        Map<Id, LT15S_Order__c> m = new Map<Id, LT15S_Order__c>(orders);
        System.assertEquals(200, fulfilments(m.keySet()).size(), '200 fulfilments expected');
    }
}