public with sharing class MCP_OpenPipelineController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpenOpportunities(Id accountId) {
        try {
            return [SELECT Id, Name, StageName, Amount, CloseDate
                    FROM Opportunity
                    WHERE AccountId = :accountId AND IsClosed = false
                    WITH USER_MODE
                    ORDER BY CloseDate ASC NULLS LAST];
        } catch (Exception e) {
            throw new AuraHandledException('We could not load open opportunities right now. Please try again or contact your administrator.');
        }
    }
}