public with sharing class LT18C_OrderEventTriggerHandler {
    public static void handleEvents(List<LT18C_Order_Event__e> events) {
        if (events == null || events.isEmpty()) { return; }
        Set<Id> ids = new Set<Id>();
        for (LT18C_Order_Event__e e : events) {
            if (e == null || e.LT18C_New_Status__c != 'Paid' || String.isBlank(e.LT18C_Order_Id__c)) { continue; }
            try {
                Id oid = Id.valueOf(e.LT18C_Order_Id__c);
                if (oid.getSobjectType() == LT18C_Order__c.SObjectType) { ids.add(oid); }
            } catch (Exception ex) {
                System.debug(LoggingLevel.WARN, 'LT18C invalid order id: ' + e.LT18C_Order_Id__c);
            }
        }
        if (ids.isEmpty()) { return; }
        Set<Id> existingOrders = new Set<Id>();
        for (LT18C_Fulfilment__c f : [SELECT LT18C_Order__c FROM LT18C_Fulfilment__c
                WHERE LT18C_Order__c IN :ids AND LT18C_Type__c = 'Pick and pack' WITH USER_MODE]) {
            existingOrders.add(f.LT18C_Order__c);
        }
        Set<Id> validOrders = new Set<Id>();
        for (LT18C_Order__c o : [SELECT Id FROM LT18C_Order__c WHERE Id IN :ids WITH USER_MODE]) {
            validOrders.add(o.Id);
        }
        List<LT18C_Fulfilment__c> toInsert = new List<LT18C_Fulfilment__c>();
        for (Id oid : ids) {
            if (validOrders.contains(oid) && !existingOrders.contains(oid)) {
                toInsert.add(new LT18C_Fulfilment__c(LT18C_Order__c = oid, LT18C_Type__c = 'Pick and pack', LT18C_Status__c = 'Open'));
            }
        }
        if (!toInsert.isEmpty()) { insert as user toInsert; }
    }
}