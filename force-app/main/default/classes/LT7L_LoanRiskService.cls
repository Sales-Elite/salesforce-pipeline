public with sharing class LT7L_LoanRiskService {
    public static String calculateBand(Decimal amount, Decimal termMonths, Decimal totalCollateral) {
        Decimal term = termMonths == null ? 0 : termMonths;
        Decimal coll = totalCollateral == null ? 0 : totalCollateral;
        if (amount == null || amount <= 0) {
            return 'High';
        }
        Decimal coverage = coll / amount;
        if (coverage < 0.5 || term > 240 || amount > 1000000) {
            return 'High';
        }
        if (coverage >= 1.0 && term <= 120 && amount <= 250000) {
            return 'Low';
        }
        return 'Medium';
    }

    public static void applyRiskBands(List<LT7L_Loan_Application__c> records) {
        if (records == null) {
            return;
        }
        for (LT7L_Loan_Application__c r : records) {
            if (r == null) {
                continue;
            }
            r.LT7L_Risk_Band__c = calculateBand(r.LT7L_Amount__c, r.LT7L_Term_Months__c, r.LT7L_Total_Collateral_Value__c);
        }
    }
}