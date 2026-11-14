public with sharing class LT14_AccountDescriptionScheduler implements Schedulable, Database.Batchable<SObject> {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new LT14_AccountDescriptionScheduler(), 200);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Description FROM Account WITH USER_MODE]);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Account> toUpdate = new List<Account>();
        for (SObject s : scope) {
            Account a = (Account) s;
            if (a.Description != 'checked') {
                toUpdate.add(new Account(Id = a.Id, Description = 'checked'));
            }
        }
        if (!toUpdate.isEmpty()) {
            Database.update(toUpdate, AccessLevel.USER_MODE);
        }
    }

    public void finish(Database.BatchableContext bc) {
    }
}