@isTest
private class ContactTriggerHandlerTest {
    @TestSetup
    static void setup() {
        Account a = new Account(Name = 'CTH Acc');
        insert a;
        List<Contact> cons = new List<Contact>();
        for (Integer i = 0; i < 4; i++) {
            cons.add(new Contact(LastName = 'C' + i, AccountId = a.Id));
        }
        insert cons;
        Opportunity openOpp = new Opportunity(Name = 'Open', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), AccountId = a.Id);
        Opportunity closedOpp = new Opportunity(Name = 'Closed', StageName = 'Closed Lost', CloseDate = Date.today(), AccountId = a.Id);
        insert new List<Opportunity>{ openOpp, closedOpp };
        insert new List<OpportunityContactRole>{
            new OpportunityContactRole(OpportunityId = openOpp.Id, ContactId = cons[0].Id, IsPrimary = true),
            new OpportunityContactRole(OpportunityId = closedOpp.Id, ContactId = cons[1].Id, IsPrimary = true),
            new OpportunityContactRole(OpportunityId = openOpp.Id, ContactId = cons[2].Id, IsPrimary = false)
        };
    }

    private static Contact byName(String n) {
        return [SELECT Id FROM Contact WHERE LastName = :n LIMIT 1];
    }

    @isTest
    static void primaryOnOpenBlocked() {
        Contact c = byName('C0');
        Test.startTest();
        Database.DeleteResult r = Database.delete(c, false);
        Test.stopTest();
        System.assert(!r.isSuccess(), 'Delete should be blocked');
        System.assert(r.getErrors()[0].getMessage().contains('primary contact on an open Opportunity'), r.getErrors()[0].getMessage());
    }

    @isTest
    static void primaryOnClosedAllowed() {
        Database.DeleteResult r = Database.delete(byName('C1'), false);
        System.assert(r.isSuccess(), 'Closed opp primary should be deletable');
    }

    @isTest
    static void nonPrimaryOnOpenAllowed() {
        Database.DeleteResult r = Database.delete(byName('C2'), false);
        System.assert(r.isSuccess(), 'Non-primary should be deletable');
    }

    @isTest
    static void noRolesAllowed() {
        Database.DeleteResult r = Database.delete(byName('C3'), false);
        System.assert(r.isSuccess(), 'No-role contact should be deletable');
    }

    @isTest
    static void bulkMixed() {
        Account a = [SELECT Id FROM Account LIMIT 1];
        Opportunity openOpp = [SELECT Id FROM Opportunity WHERE Name = 'Open' LIMIT 1];
        List<Contact> many = new List<Contact>();
        for (Integer i = 0; i < 200; i++) {
            many.add(new Contact(LastName = 'Bulk' + i, AccountId = a.Id));
        }
        insert many;
        List<OpportunityContactRole> roles = new List<OpportunityContactRole>();
        for (Integer i = 0; i < 200; i += 2) {
            roles.add(new OpportunityContactRole(OpportunityId = openOpp.Id, ContactId = many[i].Id, IsPrimary = false));
        }
        insert roles;
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 200; i += 10) {
            opps.add(new Opportunity(Name = 'BulkOpp' + i, StageName = 'Prospecting', CloseDate = Date.today().addDays(10), AccountId = a.Id));
        }
        insert opps;
        List<OpportunityContactRole> prim = new List<OpportunityContactRole>();
        Integer k = 0;
        for (Integer i = 1; i < 200; i += 10) {
            prim.add(new OpportunityContactRole(OpportunityId = opps[k].Id, ContactId = many[i].Id, IsPrimary = true));
            k++;
        }
        insert prim;
        Test.startTest();
        List<Database.DeleteResult> res = Database.delete(many, false);
        Test.stopTest();
        Integer blocked = 0;
        Integer ok = 0;
        for (Database.DeleteResult r : res) {
            if (r.isSuccess()) { ok++; } else { blocked++; }
        }
        System.assertEquals(20, blocked, 'Only primary contacts on open opps blocked');
        System.assertEquals(180, ok, 'Others deleted');
    }
}