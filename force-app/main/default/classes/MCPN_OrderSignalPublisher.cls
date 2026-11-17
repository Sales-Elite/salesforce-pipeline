public with sharing class MCPN_OrderSignalPublisher {
    public static Database.SaveResult publish(String accountId, String severity, String message) {
        MCPN_Order_Signal__e evt = new MCPN_Order_Signal__e(
            Account_Id__c = accountId,
            Severity__c = severity,
            Message__c = message
        );
        return EventBus.publish(evt);
    }
}