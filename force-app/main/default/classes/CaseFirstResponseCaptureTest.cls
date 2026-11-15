@isTest
private class CaseFirstResponseCaptureTest {
    @isTest
    static void capturesFirstOutboundOnly() {
        Case c = new Case(Subject = 'FR test', Origin = 'Email', Priority = 'High', Status = 'New', Onboarding_Tier__c = 'Gold');
        insert c;

        Test.startTest();
        EmailMessage inbound = new EmailMessage(ParentId = c.Id, Incoming = true, Subject = 'in', TextBody = 'in', Status = '0', FromAddress = 'cust@example.com', ToAddress = 'support@example.com');
        insert inbound;
        Case afterIn = [SELECT First_Response_Date__c FROM Case WHERE Id = :c.Id];
        System.assertEquals(null, afterIn.First_Response_Date__c, 'Incoming email must not set first response');

        EmailMessage out1 = new EmailMessage(ParentId = c.Id, Incoming = false, Subject = 'out1', TextBody = 'out1', Status = '3', FromAddress = 'support@example.com', ToAddress = 'cust@example.com');
        insert out1;
        Case afterOut = [SELECT First_Response_Date__c FROM Case WHERE Id = :c.Id];
        System.assertNotEquals(null, afterOut.First_Response_Date__c, 'First outbound email must set first response date');
        Datetime first = afterOut.First_Response_Date__c;

        EmailMessage out2 = new EmailMessage(ParentId = c.Id, Incoming = false, Subject = 'out2', TextBody = 'out2', Status = '3', FromAddress = 'support@example.com', ToAddress = 'cust@example.com');
        insert out2;
        Test.stopTest();

        Case afterSecond = [SELECT First_Response_Date__c FROM Case WHERE Id = :c.Id];
        System.assertEquals(first, afterSecond.First_Response_Date__c, 'Second outbound email must not overwrite first response date');
    }
}