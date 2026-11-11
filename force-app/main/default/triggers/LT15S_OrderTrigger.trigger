trigger LT15S_OrderTrigger on LT15S_Order__c (after insert, after update) {
    if (Trigger.isAfter && Trigger.isInsert) {
        LT15S_OrderTriggerHandler.handleAfterInsert(Trigger.new);
    } else if (Trigger.isAfter && Trigger.isUpdate) {
        LT15S_OrderTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}