@isTest
private class MCP_OpenPipelineControllerTest {
    @isTest
    static void returnsOnlyOpenSorted() {
        Account a = new Account(Name = 'Test Acc');
        insert a;
        Opportunity o1 = new Opportunity(Name = 'Later', AccountId = a.Id, StageName = 'Prospecting', CloseDate = Date.today().addDays(30), Amount = 200);
        Opportunity o2 = new Opportunity(Name = 'Sooner', AccountId = a.Id, StageName = 'Qualification', CloseDate = Date.today().addDays(10), Amount = 100);
        insert new List<Opportunity>{o1, o2};
        Opportunity won = new Opportunity(Name = 'Won', AccountId = a.Id, StageName = 'Closed Won', CloseDate = Date.today(), Amount = 500);
        insert won;
        Test.startTest();
        List<Opportunity> res = MCP_OpenPipelineController.getOpenOpportunities(a.Id);
        Test.stopTest();
        Set<Id> ids = new Set<Id>();
        for (Opportunity o : res) { ids.add(o.Id); }
        System.assert(ids.contains(o1.Id) && ids.contains(o2.Id), 'Both open opportunities should be returned');
        System.assert(!ids.contains(won.Id), 'Closed Won must be excluded');
        System.assertEquals(o2.Id, res[0].Id, 'Sorted by close date ascending');
    }

    @isTest
    static void emptyWhenNoOpen() {
        Account a = new Account(Name = 'Empty Acc');
        insert a;
        System.assertEquals(0, MCP_OpenPipelineController.getOpenOpportunities(a.Id).size(), 'No open opportunities expected');
    }

    @isTest
    static void userWithoutAccessGetsFriendlyError() {
        Account a = new Account(Name = 'Secret Acc');
        insert a;
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Minimum Access - Salesforce' LIMIT 1];
        User u = new User(Alias = 'noacc', Email = 'noacc@example.com', EmailEncodingKey = 'UTF-8', LastName = 'NoAccess',
            LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'noacc' + System.currentTimeMillis() + '@example.com');
        insert u;
        System.runAs(u) {
            Boolean threw = false;
            try {
                MCP_OpenPipelineController.getOpenOpportunities(a.Id);
            } catch (AuraHandledException e) {
                threw = true;
            }
            System.assert(threw, 'User without Opportunity access should get an AuraHandledException');
        }
    }
}