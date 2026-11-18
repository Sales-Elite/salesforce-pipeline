@isTest
private class N5_CampaignTriggerHandlerTest {
    @isTest
    static void blankStatusDefaultsToPlanned() {
        Campaign c = new Campaign(Name = 'N5 Blank');
        insert c;
        Campaign r = [SELECT Status FROM Campaign WHERE Id = :c.Id];
        System.assertEquals('Planned', r.Status, 'Blank status should default to Planned');
    }
    @isTest
    static void handlerFillsBlankStatusDirectly() {
        List<Campaign> cs = new List<Campaign>{
            new Campaign(Name = 'N5 A', Status = null),
            new Campaign(Name = 'N5 B', Status = ''),
            new Campaign(Name = 'N5 C', Status = 'In Progress')
        };
        N5_CampaignTriggerHandler.beforeInsert(cs);
        System.assertEquals('Planned', cs[0].Status, 'null status should be Planned');
        System.assertEquals('Planned', cs[1].Status, 'empty status should be Planned');
        System.assertEquals('In Progress', cs[2].Status, 'In Progress should be kept');
    }
    @isTest
    static void inProgressStatusIsKept() {
        Campaign c = new Campaign(Name = 'N5 InProgress', Status = 'In Progress');
        insert c;
        Campaign r = [SELECT Status FROM Campaign WHERE Id = :c.Id];
        System.assertEquals('In Progress', r.Status, 'In Progress should be kept');
    }
    @isTest
    static void bulkInsert200Campaigns() {
        List<Campaign> cs = new List<Campaign>();
        for (Integer i = 0; i < 200; i++) {
            cs.add(new Campaign(Name = 'N5 Bulk ' + i));
        }
        insert cs;
        Integer n = [SELECT COUNT() FROM Campaign WHERE Name LIKE 'N5 Bulk %' AND Status = 'Planned'];
        System.assertEquals(200, n, 'All 200 should be Planned');
    }
}