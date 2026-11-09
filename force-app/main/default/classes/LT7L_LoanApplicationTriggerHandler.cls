public with sharing class LT7L_LoanApplicationTriggerHandler {
    public static void handleBeforeInsert(List<LT7L_Loan_Application__c> newList) {
        LT7L_LoanRiskService.applyRiskBands(newList);
    }

    public static void handleBeforeUpdate(List<LT7L_Loan_Application__c> newList, Map<Id, LT7L_Loan_Application__c> oldMap) {
        List<LT7L_Loan_Application__c> toBand = new List<LT7L_Loan_Application__c>();
        for (LT7L_Loan_Application__c n : newList) {
            LT7L_Loan_Application__c o = oldMap == null ? null : oldMap.get(n.Id);
            if (o == null
                || String.isBlank(n.LT7L_Risk_Band__c)
                || n.LT7L_Amount__c != o.LT7L_Amount__c
                || n.LT7L_Term_Months__c != o.LT7L_Term_Months__c
                || n.LT7L_Total_Collateral_Value__c != o.LT7L_Total_Collateral_Value__c) {
                toBand.add(n);
            }
        }
        LT7L_LoanRiskService.applyRiskBands(toBand);
    }
}