@isTest
private class ST03_OpportunityTriggerHandlerTest {
    private static Opportunity make(String nm, Decimal disc, String region) {
        return new Opportunity(Name = nm, StageName = 'Prospecting', CloseDate = Date.today().addDays(30),
            ST03_Discount__c = disc, ST03_Region__c = region);
    }

    @isTest static void allowed() {
        Opportunity o = make('ok', 10, 'AMER');
        Database.SaveResult sr = Database.insert(o, false);
        System.assert(sr.isSuccess(), 'Within limit should save');
    }

    @isTest static void blocked() {
        Opportunity o = make('bad', 16, 'AMER');
        Database.SaveResult sr = Database.insert(o, false);
        System.assert(!sr.isSuccess(), 'Above limit should be blocked');
        System.assert(sr.getErrors()[0].getMessage().contains('exceeds'), sr.getErrors()[0].getMessage());
    }

    @isTest static void blankRegionUsesDefault() {
        Database.SaveResult bad = Database.insert(make('d1', 6, null), false);
        System.assert(!bad.isSuccess(), 'Blank region over 5 blocked');
        Database.SaveResult good = Database.insert(make('d2', 5, null), false);
        System.assert(good.isSuccess(), 'Blank region at 5 allowed');
    }

    @isTest static void bulkInsert() {
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 200; i++) {
            opps.add(make('b' + i, 4, 'EMEA'));
        }
        Test.startTest();
        ST03_OpportunityTriggerHandler.validateDiscounts(opps);
        Integer used = Limits.getQueries();
        Test.stopTest();
        System.assert(used <= 1, 'At most one query for limits, used ' + used);
        insert opps;
        System.assertEquals(200, [SELECT COUNT() FROM Opportunity WHERE Name LIKE 'b%' AND ST03_Region__c = 'EMEA'], 'All 200 inserted');
    }

    @isTest static void updateRaisesDiscount() {
        Opportunity o = make('upd', 5, 'APAC');
        insert o;
        o.ST03_Discount__c = 11;
        Database.SaveResult sr = Database.update(o, false);
        System.assert(!sr.isSuccess(), 'Raised above APAC limit should be blocked');
        o.ST03_Discount__c = 10;
        sr = Database.update(o, false);
        System.assert(sr.isSuccess(), 'At limit should save');
    }
}