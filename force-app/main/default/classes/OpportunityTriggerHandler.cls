public with sharing class OpportunityTriggerHandler {
    private static final String CLOSED_WON = 'Closed Won';

    public static void handleAfterInsert(List<Opportunity> newOpps) {
        process(newOpps, null);
    }

    public static void handleAfterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldMap) {
        process(newOpps, oldMap);
    }

    private static void process(List<Opportunity> newOpps, Map<Id, Opportunity> oldMap) {
        List<Opportunity> qualifying = new List<Opportunity>();
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity o : newOpps) {
            if (o.AccountId == null || o.StageName != CLOSED_WON) {
                continue;
            }
            if (oldMap != null) {
                Opportunity oldOpp = oldMap.get(o.Id);
                if (oldOpp != null && oldOpp.StageName == CLOSED_WON) {
                    continue;
                }
            }
            qualifying.add(o);
            accountIds.add(o.AccountId);
        }
        if (qualifying.isEmpty()) {
            return;
        }

        Map<Id, Account> accounts = new Map<Id, Account>([
            SELECT Id, OwnerId, Customer_Since__c FROM Account
            WHERE Id IN :accountIds WITH USER_MODE
        ]);

        List<Task> tasks = new List<Task>();
        Map<Id, Date> earliestClose = new Map<Id, Date>();
        for (Opportunity o : qualifying) {
            Account acc = accounts.get(o.AccountId);
            if (acc == null) {
                continue;
            }
            tasks.add(new Task(
                Subject = 'Kickoff call',
                OwnerId = acc.OwnerId,
                WhatId = o.Id,
                ActivityDate = Date.today().addDays(3),
                Status = 'Not Started'
            ));
            if (acc.Customer_Since__c == null && o.CloseDate != null) {
                Date existing = earliestClose.get(acc.Id);
                if (existing == null || o.CloseDate < existing) {
                    earliestClose.put(acc.Id, o.CloseDate);
                }
            }
        }

        if (!tasks.isEmpty()) {
            Database.insert(tasks, AccessLevel.USER_MODE);
        }
        if (!earliestClose.isEmpty()) {
            List<Account> toUpdate = new List<Account>();
            for (Id accId : earliestClose.keySet()) {
                toUpdate.add(new Account(Id = accId, Customer_Since__c = earliestClose.get(accId)));
            }
            Database.update(toUpdate, AccessLevel.USER_MODE);
        }
    }
}