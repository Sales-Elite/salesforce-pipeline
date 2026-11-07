public with sharing class ContactTriggerHandler {
    public static final String BLOCK_MESSAGE = 'This contact is the primary contact on an open Opportunity and cannot be deleted. Reassign the primary contact or close the Opportunity first.';

    public void handleBeforeDelete(List<Contact> oldContacts) {
        Set<Id> ids = new Set<Id>();
        for (Contact c : oldContacts) {
            ids.add(c.Id);
        }
        if (ids.isEmpty()) {
            return;
        }
        List<OpportunityContactRole> roles = [
            SELECT ContactId, OpportunityId, Opportunity.Name
            FROM OpportunityContactRole
            WHERE ContactId IN :ids AND IsPrimary = true AND Opportunity.IsClosed = false
            WITH USER_MODE
        ];
        Set<Id> blocked = new Set<Id>();
        for (OpportunityContactRole r : roles) {
            blocked.add(r.ContactId);
        }
        for (Contact c : oldContacts) {
            if (blocked.contains(c.Id)) {
                c.addError(BLOCK_MESSAGE);
            }
        }
    }
}