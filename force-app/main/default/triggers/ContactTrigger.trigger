trigger ContactTrigger on Contact (before delete) {
    if (Trigger.isBefore && Trigger.isDelete) {
        new ContactTriggerHandler().handleBeforeDelete(Trigger.old);
    }
}