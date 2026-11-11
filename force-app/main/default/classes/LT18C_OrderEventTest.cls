@isTest
private class LT18C_OrderEventTest {
    private static Integer countFul(Set<Id> orderIds) {
        return [SELECT COUNT() FROM LT18C_Fulfilment__c WHERE LT18C_Order__c IN :orderIds];
    }
    private static LT18C_Order__c mk() {
        LT18C_Order__c o = new LT18C_Order__c(LT18C_Total__c = 100, LT18C_Status__c = 'New');
        insert o;
        Test.getEventBus().deliver();
        return o;
    }
    private static void setStatus(LT18C_Order__c o, String s) {
        o.LT18C_Status__c = s;
        update o;
        Test.getEventBus().deliver();
    }
    @isTest static void paidCreatesOne() {
        LT18C_Order__c o = mk();
        setStatus(o, 'Paid');
        List<LT18C_Fulfilment__c> f = [SELECT LT18C_Type__c, LT18C_Status__c FROM LT18C_Fulfilment__c WHERE LT18C_Order__c = :o.Id];
        System.assertEquals(1, f.size(), 'One fulfilment expected');
        System.assertEquals('Pick and pack', f[0].LT18C_Type__c, 'Type');
        System.assertEquals('Open', f[0].LT18C_Status__c, 'Status');
    }
    @isTest static void shippedCreatesNone() {
        LT18C_Order__c o = mk();
        setStatus(o, 'Shipped');
        System.assertEquals(0, countFul(new Set<Id>{o.Id}), 'No fulfilment for Shipped');
    }
    @isTest static void paidTwiceStillOne() {
        LT18C_Order__c o = mk();
        setStatus(o, 'Paid');
        setStatus(o, 'Shipped');
        setStatus(o, 'Paid');
        System.assertEquals(1, countFul(new Set<Id>{o.Id}), 'Still one fulfilment');
    }
    @isTest static void bulk200() {
        List<LT18C_Order__c> os = new List<LT18C_Order__c>();
        for (Integer i = 0; i < 200; i++) { os.add(new LT18C_Order__c(LT18C_Total__c = 10, LT18C_Status__c = 'New')); }
        insert os;
        Test.getEventBus().deliver();
        for (LT18C_Order__c o : os) { o.LT18C_Status__c = 'Paid'; }
        update os;
        Test.getEventBus().deliver();
        Set<Id> ids = new Map<Id, LT18C_Order__c>(os).keySet();
        Integer total = 0;
        for (AggregateResult ar : [SELECT LT18C_Order__c o, COUNT(Id) c FROM LT18C_Fulfilment__c WHERE LT18C_Order__c IN :ids GROUP BY LT18C_Order__c]) {
            System.assertEquals(1, (Integer) ar.get('c'), 'One per order');
            total++;
        }
        System.assertEquals(200, total, '200 orders with fulfilments');
    }
    @isTest static void totalOnlyNoEvent() {
        LT18C_Order__c o = mk();
        o.LT18C_Total__c = 500;
        update o;
        Test.getEventBus().deliver();
        System.assertEquals(0, countFul(new Set<Id>{o.Id}), 'No fulfilment');
    }
    @isTest static void handlerEdgeCases() {
        LT18C_OrderEventTriggerHandler.handleEvents(null);
        LT18C_OrderTriggerHandler.handleAfter(null, null);
        LT18C_Order__c o = mk();
        delete o;
        List<LT18C_Order_Event__e> evs = new List<LT18C_Order_Event__e>{
            new LT18C_Order_Event__e(LT18C_Order_Id__c = 'bad', LT18C_New_Status__c = 'Paid'),
            new LT18C_Order_Event__e(LT18C_Order_Id__c = '', LT18C_New_Status__c = 'Paid'),
            new LT18C_Order_Event__e(LT18C_Order_Id__c = String.valueOf(o.Id), LT18C_New_Status__c = 'Paid')
        };
        LT18C_OrderEventTriggerHandler.handleEvents(evs);
        System.assertEquals(0, [SELECT COUNT() FROM LT18C_Fulfilment__c], 'None created');
    }
}