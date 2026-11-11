public with sharing class LT18C_OrderTriggerHandler {
    public static void handleAfter(List<LT18C_Order__c> newList, Map<Id, LT18C_Order__c> oldMap) {
        if (newList == null || newList.isEmpty()) { return; }
        List<LT18C_Order_Event__e> events = new List<LT18C_Order_Event__e>();
        for (LT18C_Order__c o : newList) {
            if (o == null || o.Id == null || o.LT18C_Status__c == null) { continue; }
            Boolean changed = true;
            if (oldMap != null) {
                LT18C_Order__c old = oldMap.get(o.Id);
                if (old != null && old.LT18C_Status__c == o.LT18C_Status__c) { changed = false; }
            }
            if (changed) {
                events.add(new LT18C_Order_Event__e(
                    LT18C_Order_Id__c = String.valueOf(o.Id),
                    LT18C_New_Status__c = o.LT18C_Status__c));
            }
        }
        if (!events.isEmpty()) {
            List<Database.SaveResult> results = EventBus.publish(events);
            for (Database.SaveResult sr : results) {
                if (!sr.isSuccess()) {
                    for (Database.Error err : sr.getErrors()) {
                        System.debug(LoggingLevel.ERROR, 'LT18C event publish failed: ' + err.getStatusCode() + ' ' + err.getMessage());
                    }
                }
            }
        }
    }
}