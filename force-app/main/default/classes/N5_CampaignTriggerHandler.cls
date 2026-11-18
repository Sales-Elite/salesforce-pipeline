public with sharing class N5_CampaignTriggerHandler {
    public static void beforeInsert(List<Campaign> newCampaigns) {
        for (Campaign c : newCampaigns) {
            if (String.isBlank(c.Status)) {
                c.Status = 'Planned';
            }
        }
    }
}