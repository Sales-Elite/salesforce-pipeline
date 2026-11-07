trigger LoanApplicationTrigger on Loan_Application__c (before insert, before update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            LoanApplicationTriggerHandler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            LoanApplicationTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when else {
            // no-op
        }
    }
}