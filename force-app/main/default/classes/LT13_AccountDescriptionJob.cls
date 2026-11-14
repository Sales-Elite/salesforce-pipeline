public with sharing class LT13_AccountDescriptionJob implements Schedulable, Database.Batchable<SObject> {
    public static final String CRON_HOURLY = '0 0 * * * ?';

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new LT13_AccountDescriptionJob(), 200);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Description FROM Account', AccessLevel.USER_MODE);
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
            Database.update(toUpdate, false, AccessLevel.USER_MODE);
        }
    }

    public void finish(Database.BatchableContext bc) {
    }
}