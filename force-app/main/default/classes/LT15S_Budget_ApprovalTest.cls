@isTest
private with sharing class LT15S_Budget_ApprovalTest {
    @isTest
    static void submitAboveThreshold() {
        LT15S_Budget_Request__c r = new LT15S_Budget_Request__c(LT15S_Amount__c = 15000, LT15S_Approver__c = UserInfo.getUserId());
        insert r;
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setObjectId(r.Id);
        Approval.ProcessResult res = Approval.process(req);
        System.assert(res.isSuccess(), 'Submission should succeed');
        LT15S_Budget_Request__c q = [SELECT LT15S_Approval_Status__c FROM LT15S_Budget_Request__c WHERE Id = :r.Id WITH USER_MODE];
        System.assertEquals('Pending', q.LT15S_Approval_Status__c, 'Status should be Pending');
        List<ProcessInstance> pis = [SELECT Id, Status FROM ProcessInstance WHERE TargetObjectId = :r.Id WITH USER_MODE];
        System.assertEquals(1, pis.size(), 'One approval instance expected');
        System.assertEquals('Pending', pis[0].Status, 'Approval instance should be pending (record locked)');
    }
    @isTest
    static void submitBelowThreshold() {
        LT15S_Budget_Request__c r = new LT15S_Budget_Request__c(LT15S_Amount__c = 5000, LT15S_Approver__c = UserInfo.getUserId());
        insert r;
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setObjectId(r.Id);
        Boolean failed = false;
        try {
            Approval.process(req);
        } catch (Exception e) {
            failed = true;
        }
        System.assert(failed, 'No approval process should apply to 5000');
    }
}