public with sharing class LoanRiskService {
    public static final Decimal MIN_DSCR_NOT_HIGH = 1.20;
    public static final Decimal MIN_DSCR_LOW = 1.50;
    public static final Decimal MAX_RATIO_NOT_HIGH = 0.85;
    public static final Decimal MAX_RATIO_LOW = 0.60;
    public static final String BAND_HIGH = 'High';
    public static final String BAND_MEDIUM = 'Medium';
    public static final String BAND_LOW = 'Low';
    public static final String STATUS_SUBMITTED = 'Submitted';

    public static String calculateRiskBand(Decimal dscr, Decimal amount, Decimal collateralValue) {
        if (dscr == null || dscr < MIN_DSCR_NOT_HIGH) {
            return BAND_HIGH;
        }
        if (collateralValue == null || collateralValue <= 0 || amount == null) {
            return BAND_HIGH;
        }
        Decimal ratio = amount / collateralValue;
        if (ratio > MAX_RATIO_NOT_HIGH) {
            return BAND_HIGH;
        }
        if (dscr >= MIN_DSCR_LOW && ratio <= MAX_RATIO_LOW) {
            return BAND_LOW;
        }
        return BAND_MEDIUM;
    }

    public static void applyRiskBands(List<Loan_Application__c> newList, Map<Id, Loan_Application__c> oldMap) {
        if (newList == null) {
            return;
        }
        for (Loan_Application__c app : newList) {
            if (app.Status__c != STATUS_SUBMITTED) {
                continue;
            }
            Boolean wasSubmitted = false;
            if (oldMap != null && app.Id != null) {
                Loan_Application__c oldApp = oldMap.get(app.Id);
                wasSubmitted = oldApp != null && oldApp.Status__c == STATUS_SUBMITTED;
            }
            if (!wasSubmitted) {
                app.Risk_Band__c = calculateRiskBand(
                    app.Debt_Service_Coverage_Ratio__c,
                    app.Amount__c,
                    app.Total_Estimated_Collateral_Value__c
                );
            }
        }
    }
}