public with sharing class LT17A_LeadDescriptionJob implements Schedulable, Database.Batchable<SObject> {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new LT17A_LeadDescriptionJob(), 200);
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Description FROM Lead
            WHERE IsConverted = false
            WITH USER_MODE
        ]);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Lead> toUpdate = new List<Lead>();
        for (SObject s : scope) {
            Lead l = (Lead) s;
            if (l.Description != 'checked') {
                l.Description = 'checked';
                toUpdate.add(l);
            }
        }
        if (!toUpdate.isEmpty()) {
            Database.update(toUpdate, AccessLevel.USER_MODE);
        }
    }

    public void finish(Database.BatchableContext bc) {
    }
}