public with sharing class LT15S_OrderTriggerHandler {
    public static void handleAfterInsert(List<LT15S_Order__c> newList) {
        List<LT15S_Order_Event__e> events = new List<LT15S_Order_Event__e>();
        for (LT15S_Order__c o : newList) {
            events.add(buildEvent(o));
        }
        publish(events);
    }

    public static void handleAfterUpdate(List<LT15S_Order__c> newList, Map<Id, LT15S_Order__c> oldMap) {
        List<LT15S_Order_Event__e> events = new List<LT15S_Order_Event__e>();
        for (LT15S_Order__c o : newList) {
            LT15S_Order__c old = oldMap == null ? null : oldMap.get(o.Id);
            if (old != null && o.LT15S_Status__c != old.LT15S_Status__c) {
                events.add(buildEvent(o));
            }
        }
        publish(events);
    }

    private static LT15S_Order_Event__e buildEvent(LT15S_Order__c o) {
        return new LT15S_Order_Event__e(
            LT15S_Order_Id__c = String.valueOf(o.Id),
            LT15S_New_Status__c = o.LT15S_Status__c
        );
    }

    private static void publish(List<LT15S_Order_Event__e> events) {
        if (!events.isEmpty()) {
            EventBus.publish(events);
        }
    }
}