@isTest
private class LT7L_LoanRiskServiceTest {
    @isTest static void lowBand() {
        System.assertEquals('Low', LT7L_LoanRiskService.calculateBand(100000, 60, 100000), 'low');
    }
    @isTest static void mediumBand() {
        System.assertEquals('Medium', LT7L_LoanRiskService.calculateBand(100000, 180, 60000), 'medium by term');
        System.assertEquals('Medium', LT7L_LoanRiskService.calculateBand(500000, 60, 600000), 'medium by amount');
    }
    @isTest static void highByCoverage() {
        System.assertEquals('High', LT7L_LoanRiskService.calculateBand(100000, 60, 10000), 'coverage');
    }
    @isTest static void highByTerm() {
        System.assertEquals('High', LT7L_LoanRiskService.calculateBand(100000, 300, 200000), 'term');
    }
    @isTest static void highByAmount() {
        System.assertEquals('High', LT7L_LoanRiskService.calculateBand(2000000, 60, 5000000), 'amount');
    }
    @isTest static void nullAndZeroAmount() {
        System.assertEquals('High', LT7L_LoanRiskService.calculateBand(null, 60, 100), 'null amount');
        System.assertEquals('High', LT7L_LoanRiskService.calculateBand(0, 60, 100), 'zero amount');
    }
    @isTest static void nullCollateralAndTerm() {
        System.assertEquals('High', LT7L_LoanRiskService.calculateBand(100000, null, null), 'null collateral');
        System.assertEquals('Low', LT7L_LoanRiskService.calculateBand(100000, null, 100000), 'null term');
    }
    @isTest static void applyNullSafe() {
        LT7L_LoanRiskService.applyRiskBands(null);
        List<LT7L_Loan_Application__c> l = new List<LT7L_Loan_Application__c>{
            null, new LT7L_Loan_Application__c(LT7L_Amount__c = 100000, LT7L_Term_Months__c = 60)
        };
        LT7L_LoanRiskService.applyRiskBands(l);
        System.assertEquals('High', l[1].LT7L_Risk_Band__c, 'no collateral');
    }
}