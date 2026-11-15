@isTest
private class LT10U_Big_Deal_ApprovalTest {
    private static User mk(String alias, Id profId, Id mgrId) {
        return new User(Alias = alias, Email = alias + '@lt10u.example.com',
            EmailEncodingKey = 'UTF-8', LastName = 'T' + alias, LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', ProfileId = profId, TimeZoneSidKey = 'America/Los_Angeles',
            UserName = alias + System.currentTimeMillis() + '@lt10u.example.com', ManagerId = mgrId);
    }
    private static Opportunity mkOpp(Decimal amt) {
        Opportunity o = new Opportunity(Name = 'LT10U Opp', StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30), Amount = amt);
        insert o;
        return o;
    }
    private static Boolean isLockedByDml(Opportunity o) {
        Boolean locked = false;
        try {
            o.Name = 'Changed';
            update o;
        } catch (DmlException e) {
            locked = e.getMessage().contains('ENTITY_IS_LOCKED');
        }
        return locked;
    }
    @isTest
    static void submitBigDeal() {
        Id adm = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        Id std = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;
        User mgr = mk('lt10m', adm, null);
        insert mgr;
        User sub = mk('lt10s', std, mgr.Id);
        insert sub;
        System.runAs(sub) {
            Opportunity o = mkOpp(600000);
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(o.Id);
            req.setSubmitterId(sub.Id);
            req.setProcessDefinitionNameOrId('LT10U_Big_Deal');
            req.setSkipEntryCriteria(false);
            Approval.ProcessResult r = Approval.process(req);
            System.assert(r.isSuccess(), 'Submission should succeed');
            System.assertEquals('Pending', r.getInstanceStatus(), 'Should be pending');
            ProcessInstanceWorkitem w = [SELECT ActorId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :o.Id LIMIT 1];
            System.assertEquals(mgr.Id, w.ActorId, 'Routes to manager');
            System.assert(isLockedByDml(o), 'Opportunity should be locked');
        }
    }
    @isTest
    static void plainSubmitReachesLT10U() {
        Id adm = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        Id std = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;
        User mgr = mk('lt10p', adm, null);
        insert mgr;
        User sub = mk('lt10q', std, mgr.Id);
        insert sub;
        System.runAs(sub) {
            Opportunity o = mkOpp(600000);
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(o.Id);
            req.setSubmitterId(sub.Id);
            Approval.ProcessResult r = Approval.process(req);
            System.assert(r.isSuccess(), 'Submission should succeed');
            ProcessInstance pi = [SELECT ProcessDefinition.DeveloperName FROM ProcessInstance WHERE TargetObjectId = :o.Id LIMIT 1];
            System.assertEquals('LT10U_Big_Deal', pi.ProcessDefinition.DeveloperName, 'Plain submit should reach LT10U_Big_Deal');
            ProcessInstanceWorkitem w = [SELECT ActorId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :o.Id LIMIT 1];
            System.assertEquals(mgr.Id, w.ActorId, 'Routes to manager');
            System.assert(isLockedByDml(o), 'Opportunity should be locked');
        }
    }
    @isTest
    static void smallDealNotEligible() {
        Id adm = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        User mgr = mk('lt10n', adm, null);
        insert mgr;
        User sub = mk('lt10t', adm, mgr.Id);
        insert sub;
        System.runAs(sub) {
            Opportunity o = mkOpp(400000);
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(o.Id);
            req.setProcessDefinitionNameOrId('LT10U_Big_Deal');
            req.setSkipEntryCriteria(false);
            Boolean failed = false;
            try {
                Approval.ProcessResult r = Approval.process(req);
                failed = !r.isSuccess();
            } catch (Exception e) {
                failed = true;
            }
            System.assert(failed, 'Small deal should not be eligible');
        }
    }
}