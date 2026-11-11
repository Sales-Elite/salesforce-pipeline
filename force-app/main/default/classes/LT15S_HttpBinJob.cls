public with sharing class LT15S_HttpBinJob implements Queueable, Database.AllowsCallouts {
    public String requestId { get; private set; }

    public LT15S_HttpBinJob(String requestId) {
        this.requestId = requestId;
    }

    public void execute(QueueableContext ctx) {
        LT15S_HttpBinClient.Result r = LT15S_HttpBinClient.lookup(requestId);
        LT15S_Lookup_Log__c log = new LT15S_Lookup_Log__c(
            LT15S_Request_Id__c = requestId,
            LT15S_Status_Code__c = r.statusCode,
            LT15S_Origin__c = r.origin,
            LT15S_Error__c = r.error == null ? null : r.error.left(255),
            LT15S_Called_At__c = System.now()
        );
        insert as user log;
    }
}