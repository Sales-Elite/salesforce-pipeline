public with sharing class ST03_OpportunityTriggerHandler {
    private static Map<String, Decimal> limitsByRegion;

    private static Map<String, Decimal> getLimits() {
        if (limitsByRegion == null) {
            limitsByRegion = new Map<String, Decimal>();
            for (ST03_Discount_Limit__mdt l : [SELECT ST03_Region__c, ST03_Max_Discount__c FROM ST03_Discount_Limit__mdt WITH USER_MODE]) {
                if (l.ST03_Region__c != null && l.ST03_Max_Discount__c != null) {
                    limitsByRegion.put(l.ST03_Region__c.toUpperCase(), l.ST03_Max_Discount__c);
                }
            }
        }
        return limitsByRegion;
    }

    public static void validateDiscounts(List<Opportunity> records) {
        Map<String, Decimal> limits = getLimits();
        Decimal defaultLimit = limits.get('DEFAULT');
        for (Opportunity o : records) {
            if (o.ST03_Discount__c == null) {
                continue;
            }
            Decimal maxAllowed = defaultLimit;
            if (String.isNotBlank(o.ST03_Region__c) && limits.containsKey(o.ST03_Region__c.toUpperCase())) {
                maxAllowed = limits.get(o.ST03_Region__c.toUpperCase());
            }
            if (maxAllowed != null && o.ST03_Discount__c > maxAllowed) {
                o.ST03_Discount__c.addError('Discount exceeds the maximum of ' + maxAllowed + '% allowed for this region.');
            }
        }
    }
}