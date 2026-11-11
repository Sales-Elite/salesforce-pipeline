trigger LT18C_OrderEventTrigger on LT18C_Order_Event__e (after insert) {
    LT18C_OrderEventTriggerHandler.handleEvents(Trigger.new);
}