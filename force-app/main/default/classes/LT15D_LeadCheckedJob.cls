public with sharing class LT15D_LeadCheckedJob implements Schedulable, Database.Batchable<SObject> {
    public static final String CRON_HOURLY = '0 0 * * * ?';

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new LT15D_LeadCheckedJob(), 200);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Description FROM Lead WHERE IsConverted = false', AccessLevel.USER_MODE);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Lead> toUpdate = new List<Lead>();
        for (SObject so : scope) {
            Lead l = (Lead) so;
            if (l.Description != 'checked') {
                toUpdate.add(new Lead(Id = l.Id, Description = 'checked'));
            }
        }
        if (!toUpdate.isEmpty()) {
            Database.update(toUpdate, false, AccessLevel.USER_MODE);
        }
    }

    public void finish(Database.BatchableContext bc) {
    }
}