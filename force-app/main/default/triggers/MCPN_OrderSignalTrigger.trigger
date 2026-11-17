trigger MCPN_OrderSignalTrigger on MCPN_Order_Signal__e (after insert) {
    MCPN_OrderSignalHandler.handleAfterInsert(Trigger.new);
}