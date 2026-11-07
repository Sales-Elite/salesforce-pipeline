public with sharing class LoanApplicationTriggerHandler {
    public static void beforeInsert(List<Loan_Application__c> newList) {
        LoanRiskService.applyRiskBands(newList, null);
    }

    public static void beforeUpdate(List<Loan_Application__c> newList, Map<Id, Loan_Application__c> oldMap) {
        LoanRiskService.applyRiskBands(newList, oldMap);
    }
}