trigger LT7L_LoanApplicationTrigger on LT7L_Loan_Application__c (before insert, before update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            LT7L_LoanApplicationTriggerHandler.handleBeforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            LT7L_LoanApplicationTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when else {
        }
    }
}