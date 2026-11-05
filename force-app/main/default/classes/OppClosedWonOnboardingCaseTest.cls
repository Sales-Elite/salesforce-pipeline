@isTest
private class OppClosedWonOnboardingCaseTest {
    @isTest
    static void createsOnboardingCaseOnce() {
        Account a = new Account(Name = 'Onb Test Acct');
        insert a;
        Contact c = new Contact(LastName = 'Primary', AccountId = a.Id);
        insert c;
        Opportunity o = new Opportunity(Name = 'Onb Test Opp', AccountId = a.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(30));
        insert o;
        insert new OpportunityContactRole(OpportunityId = o.Id, ContactId = c.Id, IsPrimary = true);
        Test.startTest();
        o.StageName = 'Closed Won';
        update o;
        Test.stopTest();
        Id queueId = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = 'Onboarding' LIMIT 1].Id;
        List<Case> cases = [SELECT Id, ContactId, OwnerId, Onboarding_Tier__c FROM Case WHERE AccountId = :a.Id AND Subject = 'Onboarding: Onb Test Opp'];
        System.assertEquals(1, cases.size());
        System.assertEquals(c.Id, cases[0].ContactId);
        System.assertEquals(queueId, cases[0].OwnerId);
        System.assertEquals('Bronze', cases[0].Onboarding_Tier__c);
        update o;
        System.assertEquals(1, [SELECT count() FROM Case WHERE AccountId = :a.Id AND Subject = 'Onboarding: Onb Test Opp']);
    }
}