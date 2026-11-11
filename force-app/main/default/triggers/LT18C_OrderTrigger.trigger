trigger LT18C_OrderTrigger on LT18C_Order__c (after insert, after update) {
    LT18C_OrderTriggerHandler.handleAfter(Trigger.new, Trigger.isUpdate ? Trigger.oldMap : null);
}