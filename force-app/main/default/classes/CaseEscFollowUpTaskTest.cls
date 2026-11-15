@isTest
private class CaseEscFollowUpTaskTest {
    static String reason() {
        return Case.Escalation_Reason__c.getDescribe().getPicklistValues()[0].getValue();
    }
    static Case mk() {
        Case c = new Case(Subject='Esc test', Origin='Web', Status='New', Onboarding_Tier__c='Gold');
        insert c;
        return c;
    }
    @isTest static void escalateCreatesOneTask() {
        Case c = mk();
        c.IsEscalated = true;
        c.Escalation_Reason__c = reason();
        update c;
        c.Priority = 'Low';
        update c;
        Case fresh = [SELECT CaseNumber, OwnerId FROM Case WHERE Id = :c.Id];
        List<Task> ts = [SELECT OwnerId, Subject, ActivityDate, Description FROM Task WHERE WhatId = :c.Id AND Subject = 'Escalation follow-up'];
        System.assertEquals(1, ts.size());
        System.assertEquals(fresh.OwnerId, ts[0].OwnerId);
        System.assertEquals(Date.today().addDays(1), ts[0].ActivityDate);
        System.assert(ts[0].Description.contains(fresh.CaseNumber));
    }
    @isTest static void nonEscalatedNoTask() {
        Case c = mk();
        c.Priority = 'Low';
        update c;
        System.assertEquals(0, [SELECT COUNT() FROM Task WHERE WhatId = :c.Id AND Subject = 'Escalation follow-up']);
    }
}