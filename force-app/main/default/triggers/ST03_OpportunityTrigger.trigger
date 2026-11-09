trigger ST03_OpportunityTrigger on Opportunity (before insert, before update) {
    ST03_OpportunityTriggerHandler.validateDiscounts(Trigger.new);
}