@isTest
private with sharing class LT11A_Big_Deal_ApprovalTest {
    private static User mkUser(String alias, Id managerId) {
        Id profId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        return new User(Alias = alias, Email = alias + '@lt11a.test', EmailEncodingKey = 'UTF-8',
            LastName = alias, LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = profId,
            TimeZoneSidKey = 'America/Los_Angeles', UserName = alias + System.currentTimeMillis() + '@lt11a.test',
            ManagerId = managerId);
    }

    private static Opportunity mkOpp(Decimal amt) {
        Account a = new Account(Name = 'LT11A Acct');
        insert a;
        Opportunity o = new Opportunity(Name = 'LT11A Opp', AccountId = a.Id, Amount = amt,
            StageName = 'Prospecting', CloseDate = Date.today().addDays(30));
        insert o;
        return o;
    }

    @isTest
    static void bigDealSubmitsAndLocks() {
        User mgr = mkUser('l11mgr', null);
        insert mgr;
        User sub = mkUser('l11sub', mgr.Id);
        insert sub;
        System.runAs(sub) {
            Opportunity o = mkOpp(600000);
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(o.Id);
            req.setSubmitterId(sub.Id);
            req.setProcessDefinitionNameOrId('LT11A_Big_Deal');
            req.setSkipEntryCriteria(false);
            Approval.ProcessResult res = Approval.process(req);
            System.assert(res.isSuccess(), 'Submission should succeed');
            System.assertEquals('Pending', res.getInstanceStatus(), 'Status should be Pending');
            ProcessInstanceWorkitem wi = [SELECT ActorId FROM ProcessInstanceWorkitem
                WHERE ProcessInstance.TargetObjectId = :o.Id LIMIT 1];
            System.assertEquals(mgr.Id, wi.ActorId, 'Assigned to manager');
            ProcessInstance pi = [SELECT Status FROM ProcessInstance WHERE TargetObjectId = :o.Id LIMIT 1];
            System.assertEquals('Pending', pi.Status, 'Approval pending, record locked');
        }
    }

    @isTest
    static void smallDealRejected() {
        User mgr = mkUser('l11mgr2', null);
        insert mgr;
        User sub = mkUser('l11sub2', mgr.Id);
        insert sub;
        System.runAs(sub) {
            Opportunity o = mkOpp(400000);
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(o.Id);
            req.setProcessDefinitionNameOrId('LT11A_Big_Deal');
            req.setSkipEntryCriteria(false);
            Boolean failed = false;
            try {
                Approval.ProcessResult res = Approval.process(req);
                failed = !res.isSuccess();
            } catch (Exception e) {
                failed = true;
            }
            System.assert(failed, 'Small deal should not be accepted');
        }
    }
}