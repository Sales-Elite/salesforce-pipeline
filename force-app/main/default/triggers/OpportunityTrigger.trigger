trigger OpportunityTrigger on Opportunity (after insert, after update) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            OpportunityTriggerHandler.handleAfterInsert(Trigger.new);
        }
        when AFTER_UPDATE {
            OpportunityTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
        }
        when else {
        }
    }
}