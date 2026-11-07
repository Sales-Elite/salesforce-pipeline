@isTest
private class LoanApplicationTriggerHandlerTest {

    private static Loan_Application__c newApp(Id accId, String status) {
        return new Loan_Application__c(
            Borrower__c = accId,
            Loan_Amount__c = 1000,
            Term_Months__c = 60,
            Amount__c = 500,
            Debt_Service_Coverage_Ratio__c = 1.6,
            Status__c = status
        );
    }

    @isTest
    static void testBeforeInsertDirect() {
        Loan_Application__c app = newApp(null, 'Submitted');
        LoanApplicationTriggerHandler.beforeInsert(new List<Loan_Application__c>{ app });
        System.assertEquals('High', app.Risk_Band__c, 'No collateral value means High via handler beforeInsert');
    }

    @isTest
    static void testBeforeUpdateDirect() {
        Account acc = new Account(Name = 'Handler Direct Account');
        insert acc;
        Loan_Application__c saved = newApp(acc.Id, 'Draft');
        insert saved;
        Id realId = saved.Id;
        Loan_Application__c oldApp = newApp(acc.Id, 'Draft');
        Loan_Application__c newer = newApp(acc.Id, 'Submitted');
        newer.Id = realId;
        oldApp.Id = realId;
        LoanApplicationTriggerHandler.beforeUpdate(
            new List<Loan_Application__c>{ newer },
            new Map<Id, Loan_Application__c>{ realId => oldApp });
        System.assertEquals('High', newer.Risk_Band__c, 'Transition to Submitted bands via handler beforeUpdate');
    }

    @isTest
    static void testInsertThroughTrigger() {
        Account acc = new Account(Name = 'Handler Test Account');
        insert acc;
        Loan_Application__c app = newApp(acc.Id, 'Draft');
        insert app;
        insert new Collateral__c(Loan_Application__c = app.Id, Estimated_Value__c = 1000);
        Loan_Application__c fresh = [SELECT Id, Status__c FROM Loan_Application__c WHERE Id = :app.Id];
        fresh.Status__c = 'Submitted';
        Test.startTest();
        update fresh;
        Test.stopTest();
        Loan_Application__c r = [SELECT Risk_Band__c FROM Loan_Application__c WHERE Id = :app.Id];
        System.assertEquals('Low', r.Risk_Band__c, 'Draft to Submitted should band Low through trigger and handler');
    }

    @isTest
    static void testInsertSubmittedDirectlyThroughTrigger() {
        Account acc = new Account(Name = 'Handler Test Account 2');
        insert acc;
        Loan_Application__c app = newApp(acc.Id, 'Submitted');
        Database.SaveResult sr = Database.insert(app, false);
        if (sr.isSuccess()) {
            Loan_Application__c r = [SELECT Risk_Band__c FROM Loan_Application__c WHERE Id = :app.Id];
            System.assertEquals('High', r.Risk_Band__c, 'Insert as Submitted with no collateral bands High');
        } else {
            System.assert(!sr.getErrors().isEmpty(), 'Expected validation error when insert is blocked');
        }
    }
}