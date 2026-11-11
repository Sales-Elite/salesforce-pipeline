public with sharing class LT15S_OrderEventTriggerHandler {
    public static final String FULFILMENT_TYPE = 'Pick and pack';

    public static void handleAfterInsert(List<LT15S_Order_Event__e> events) {
        Set<Id> orderIds = new Set<Id>();
        for (LT15S_Order_Event__e e : events) {
            if (e.LT15S_New_Status__c == 'Paid' && !String.isBlank(e.LT15S_Order_Id__c)) {
                try {
                    orderIds.add((Id) e.LT15S_Order_Id__c);
                } catch (Exception ex) {
                    System.debug(LoggingLevel.WARN, 'Invalid order id on event: ' + e.LT15S_Order_Id__c);
                }
            }
        }
        if (orderIds.isEmpty()) {
            return;
        }
        Set<Id> existing = new Set<Id>();
        for (LT15S_Fulfilment__c f : [SELECT LT15S_Order__c FROM LT15S_Fulfilment__c
                                      WHERE LT15S_Order__c IN :orderIds AND LT15S_Type__c = :FULFILMENT_TYPE
                                      WITH USER_MODE]) {
            existing.add(f.LT15S_Order__c);
        }
        Set<Id> valid = new Set<Id>();
        for (LT15S_Order__c o : [SELECT Id FROM LT15S_Order__c WHERE Id IN :orderIds WITH USER_MODE]) {
            valid.add(o.Id);
        }
        List<LT15S_Fulfilment__c> toInsert = new List<LT15S_Fulfilment__c>();
        for (Id oid : orderIds) {
            if (valid.contains(oid) && !existing.contains(oid)) {
                toInsert.add(new LT15S_Fulfilment__c(
                    LT15S_Order__c = oid,
                    LT15S_Type__c = FULFILMENT_TYPE,
                    LT15S_Status__c = 'Open'
                ));
            }
        }
        if (!toInsert.isEmpty()) {
            insert as user toInsert;
        }
    }
}