@isTest
private class LT7L_LoanApplicationTriggerHandlerTest {
    private static Account acct() {
        Account a = new Account(Name = 'LT7L Test Acct');
        insert a;
        return a;
    }
    private static LT7L_Loan_Application__c app(Id accId, Decimal amt, Decimal term) {
        return new LT7L_Loan_Application__c(LT7L_Account__c = accId, LT7L_Amount__c = amt, LT7L_Term_Months__c = term);
    }

    @isTest static void insertSetsBand() {
        Account a = acct();
        LT7L_Loan_Application__c l = app(a.Id, 100000, 60);
        insert l;
        l = [SELECT LT7L_Risk_Band__c FROM LT7L_Loan_Application__c WHERE Id = :l.Id];
        System.assertEquals('High', l.LT7L_Risk_Band__c, 'no collateral means High');
    }

    @isTest static void amountChangeRebands() {
        Account a = acct();
        LT7L_Loan_Application__c l = app(a.Id, 100000, 60);
        insert l;
        l.LT7L_Amount__c = 2000000;
        update l;
        l = [SELECT LT7L_Risk_Band__c FROM LT7L_Loan_Application__c WHERE Id = :l.Id];
        System.assertEquals('High', l.LT7L_Risk_Band__c, 'amount change');
        l.LT7L_Risk_Band__c = null;
        update l;
        l = [SELECT LT7L_Risk_Band__c FROM LT7L_Loan_Application__c WHERE Id = :l.Id];
        System.assertEquals('High', l.LT7L_Risk_Band__c, 'blank band re-banded');
    }

    @isTest static void unrelatedUpdateKeepsOverride() {
        Account a = acct();
        LT7L_Loan_Application__c l = app(a.Id, 100000, 60);
        insert l;
        l.LT7L_Risk_Band__c = 'Low';
        update l;
        l = [SELECT LT7L_Risk_Band__c FROM LT7L_Loan_Application__c WHERE Id = :l.Id];
        System.assertEquals('Low', l.LT7L_Risk_Band__c, 'manual override kept');
        update l;
        l = [SELECT LT7L_Risk_Band__c FROM LT7L_Loan_Application__c WHERE Id = :l.Id];
        System.assertEquals('Low', l.LT7L_Risk_Band__c, 'override kept on unrelated update');
    }

    @isTest static void collateralRollupChangesBand() {
        Account a = acct();
        LT7L_Loan_Application__c l = app(a.Id, 100000, 60);
        insert l;
        insert new LT7L_Collateral__c(LT7L_Loan_Application__c = l.Id, LT7L_Estimated_Value__c = 150000);
        l = [SELECT LT7L_Risk_Band__c, LT7L_Total_Collateral_Value__c FROM LT7L_Loan_Application__c WHERE Id = :l.Id];
        System.assertEquals(150000, l.LT7L_Total_Collateral_Value__c, 'rollup');
        System.assertEquals('Low', l.LT7L_Risk_Band__c, 'collateral re-bands to Low');
    }

    @isTest static void bulkTwoHundred() {
        Account a = acct();
        List<LT7L_Loan_Application__c> ls = new List<LT7L_Loan_Application__c>();
        for (Integer i = 0; i < 200; i++) {
            ls.add(app(a.Id, 100000, 60));
        }
        insert ls;
        for (LT7L_Loan_Application__c l : [SELECT LT7L_Risk_Band__c FROM LT7L_Loan_Application__c]) {
            System.assertEquals('High', l.LT7L_Risk_Band__c, 'bulk insert band');
        }
        for (LT7L_Loan_Application__c l : ls) {
            l.LT7L_Amount__c = 300000;
        }
        update ls;
        Integer n = 0;
        for (LT7L_Loan_Application__c l : [SELECT LT7L_Risk_Band__c FROM LT7L_Loan_Application__c]) {
            System.assertEquals('High', l.LT7L_Risk_Band__c, 'bulk update band');
            n++;
        }
        System.assertEquals(200, n, 'count');
    }

    @isTest static void negativeCases() {
        Account a = acct();
        List<LT7L_Loan_Application__c> bad = new List<LT7L_Loan_Application__c>{
            app(a.Id, 0, 60), app(a.Id, 1000, 5), app(a.Id, 1000, 361)
        };
        Boolean thrown = false;
        try {
            insert bad;
        } catch (DmlException e) {
            thrown = true;
        }
        System.assert(thrown, 'should be rejected');
        System.assertEquals(0, [SELECT COUNT() FROM LT7L_Loan_Application__c], 'none saved');
    }
}