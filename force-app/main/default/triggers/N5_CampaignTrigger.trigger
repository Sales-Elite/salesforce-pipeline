trigger N5_CampaignTrigger on Campaign (before insert) {
    N5_CampaignTriggerHandler.beforeInsert(Trigger.new);
}