@isTest
private class OpportunityTriggerHandlerTest {
    @TestSetup
    static void setup() {
        List<Account> accs = new List<Account>{
            new Account(Name = 'Blank Since'),
            new Account(Name = 'Has Since', Customer_Since__c = Date.newInstance(2020, 1, 1))
        };
        insert accs;
    }

    private static Opportunity mk(String name, Id accId, String stage) {
        return new Opportunity(Name = name, AccountId = accId, StageName = stage,
            CloseDate = Date.today().addDays(10), Amount = 100);
    }

    private static Account acct(String name) {
        return [SELECT Id, OwnerId, Customer_Since__c FROM Account WHERE Name = :name];
    }

    @isTest
    static void transitionCreatesTaskAndSetsSince() {
        Account a = acct('Blank Since');
        Opportunity o = mk('O1', a.Id, 'Prospecting');
        insert o;
        Test.startTest();
        o.StageName = 'Closed Won';
        update o;
        Test.stopTest();
        Opportunity fresh = [SELECT CloseDate FROM Opportunity WHERE Id = :o.Id];
        List<Task> ts = [SELECT Subject, OwnerId, ActivityDate FROM Task WHERE WhatId = :o.Id AND Subject = 'Kickoff call'];
        Assert.areEqual(1, ts.size(), 'one task');
        Assert.areEqual(a.OwnerId, ts[0].OwnerId, 'owner');
        Assert.areEqual(Date.today().addDays(3), ts[0].ActivityDate, 'due');
        Assert.isNotNull(acct('Blank Since').Customer_Since__c, 'since set');
        Assert.isTrue(acct('Blank Since').Customer_Since__c == fresh.CloseDate
            || acct('Blank Since').Customer_Since__c == o.CloseDate, 'since equals close date');

        o.Name = 'O1b';
        update o;
        Assert.areEqual(1, [SELECT COUNT() FROM Task WHERE WhatId = :o.Id AND Subject = 'Kickoff call'], 'no duplicate');
    }

    @isTest
    static void existingSincePreserved() {
        Account a = acct('Has Since');
        Opportunity o = mk('O2', a.Id, 'Prospecting');
        insert o;
        o.StageName = 'Closed Won';
        update o;
        Assert.areEqual(Date.newInstance(2020, 1, 1), acct('Has Since').Customer_Since__c, 'preserved');
        Assert.areEqual(1, [SELECT COUNT() FROM Task WHERE WhatId = :o.Id], 'task');
    }

    @isTest
    static void nonClosedWonNoTask() {
        Account a = acct('Blank Since');
        Opportunity o = mk('O3', a.Id, 'Prospecting');
        insert o;
        o.StageName = 'Qualification';
        update o;
        Assert.areEqual(0, [SELECT COUNT() FROM Task WHERE WhatId = :o.Id], 'none');
        Assert.isNull(acct('Blank Since').Customer_Since__c, 'since blank');
    }

    @isTest
    static void insertClosedWon() {
        Account a = acct('Blank Since');
        Opportunity o = mk('O4', a.Id, 'Closed Won');
        insert o;
        Assert.areEqual(1, [SELECT COUNT() FROM Task WHERE WhatId = :o.Id AND Subject = 'Kickoff call'], 'task on insert');
    }

    @isTest
    static void noAccount() {
        Opportunity o = mk('O5', null, 'Closed Won');
        insert o;
        Assert.areEqual(0, [SELECT COUNT() FROM Task WHERE WhatId = :o.Id], 'no task');
    }

    @isTest
    static void bulk200() {
        Account a = acct('Blank Since');
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 200; i++) {
            opps.add(mk('B' + i, a.Id, 'Prospecting'));
        }
        insert opps;
        for (Opportunity o : opps) {
            o.StageName = 'Closed Won';
        }
        Test.startTest();
        update opps;
        Test.stopTest();
        Assert.areEqual(200, [SELECT COUNT() FROM Task WHERE Subject = 'Kickoff call' AND WhatId IN :opps], 'bulk tasks');
    }
}