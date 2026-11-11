trigger LT15S_OrderEventTrigger on LT15S_Order_Event__e (after insert) {
    LT15S_OrderEventTriggerHandler.handleAfterInsert(Trigger.new);
}