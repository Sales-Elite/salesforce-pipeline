@isTest
private class LoanRiskServiceTest {

    private static Account makeAccount() {
        Account a = new Account(Name = 'Loan Risk Test Account');
        insert a;
        return a;
    }

    // Creates Draft applications, each with one collateral record, ready to be submitted.
    private static List<Loan_Application__c> makeDraftApps(Id accId, Integer n, Decimal dscr, Decimal amount, Decimal collateralValue) {
        List<Loan_Application__c> apps = new List<Loan_Application__c>();
        for (Integer i = 0; i < n; i++) {
            apps.add(new Loan_Application__c(
                Borrower__c = accId,
                Loan_Amount__c = 1000,
                Term_Months__c = 60,
                Amount__c = amount,
                Debt_Service_Coverage_Ratio__c = dscr,
                Status__c = 'Draft'
            ));
        }
        insert apps;
        List<Collateral__c> cols = new List<Collateral__c>();
        for (Loan_Application__c app : apps) {
            cols.add(new Collateral__c(Loan_Application__c = app.Id, Estimated_Value__c = collateralValue));
        }
        insert cols;
        return apps;
    }

    private static List<Loan_Application__c> reload(List<Loan_Application__c> apps) {
        return [SELECT Id, Status__c, Risk_Band__c, Amount__c, Debt_Service_Coverage_Ratio__c, Total_Estimated_Collateral_Value__c
                FROM Loan_Application__c WHERE Id IN :apps];
    }

    private static void submit(List<Loan_Application__c> apps) {
        List<Loan_Application__c> fresh = reload(apps);
        for (Loan_Application__c a : fresh) {
            a.Status__c = 'Submitted';
        }
        update fresh;
    }

    @isTest
    static void testLowBand() {
        Account acc = makeAccount();
        List<Loan_Application__c> apps = makeDraftApps(acc.Id, 1, 1.6, 500, 1000);
        Test.startTest();
        submit(apps);
        Test.stopTest();
        Loan_Application__c r = reload(apps)[0];
        System.assertEquals('Low', r.Risk_Band__c, 'Expected Low band');
    }

    @isTest
    static void testMediumBand() {
        Account acc = makeAccount();
        List<Loan_Application__c> apps = makeDraftApps(acc.Id, 1, 1.3, 700, 1000);
        Test.startTest();
        submit(apps);
        Test.stopTest();
        Loan_Application__c r = reload(apps)[0];
        System.assertEquals('Medium', r.Risk_Band__c, 'Expected Medium band');
    }

    @isTest
    static void testHighBandLowDscr() {
        Account acc = makeAccount();
        List<Loan_Application__c> apps = makeDraftApps(acc.Id, 1, 1.0, 500, 1000);
        Test.startTest();
        submit(apps);
        Test.stopTest();
        Loan_Application__c r = reload(apps)[0];
        System.assertEquals('High', r.Risk_Band__c, 'Expected High band for low DSCR');
    }

    @isTest
    static void testHighBandHighRatio() {
        Account acc = makeAccount();
        List<Loan_Application__c> apps = makeDraftApps(acc.Id, 1, 1.8, 900, 1000);
        Test.startTest();
        submit(apps);
        Test.stopTest();
        Loan_Application__c r = reload(apps)[0];
        System.assertEquals('High', r.Risk_Band__c, 'Expected High band for ratio above 0.85');
    }

    @isTest
    static void testBulk200() {
        Account acc = makeAccount();
        List<Loan_Application__c> apps = makeDraftApps(acc.Id, 200, 1.6, 500, 1000);
        Test.startTest();
        submit(apps);
        Test.stopTest();
        List<Loan_Application__c> results = reload(apps);
        System.assertEquals(200, results.size(), 'Expected 200 applications');
        for (Loan_Application__c r : results) {
            System.assertEquals('Low', r.Risk_Band__c, 'Every application should be Low');
        }
    }

    @isTest
    static void testNonSubmitUpdateDoesNotChangeBand() {
        Account acc = makeAccount();
        List<Loan_Application__c> apps = makeDraftApps(acc.Id, 1, 1.6, 500, 1000);
        Test.startTest();
        List<Loan_Application__c> fresh = reload(apps);
        fresh[0].Term_Months__c = 120;
        update fresh;
        Test.stopTest();
        Loan_Application__c r = reload(apps)[0];
        System.assertEquals(null, r.Risk_Band__c, 'Band must not be set on a non-submit update');
    }

    @isTest
    static void testResaveWhileSubmittedKeepsBand() {
        Account acc = makeAccount();
        List<Loan_Application__c> apps = makeDraftApps(acc.Id, 1, 1.6, 500, 1000);
        submit(apps);
        Test.startTest();
        List<Loan_Application__c> fresh = reload(apps);
        fresh[0].Debt_Service_Coverage_Ratio__c = 0.5;
        update fresh;
        Test.stopTest();
        Loan_Application__c r = reload(apps)[0];
        System.assertEquals('Low', r.Risk_Band__c, 'Band is only computed on the transition to Submitted');
    }

    @isTest
    static void testInsertAsSubmittedBandsHigh() {
        Account acc = makeAccount();
        Test.startTest();
        Loan_Application__c app = new Loan_Application__c(
            Borrower__c = acc.Id, Loan_Amount__c = 1000, Term_Months__c = 60,
            Debt_Service_Coverage_Ratio__c = 1.6, Status__c = 'Submitted');
        Database.SaveResult sr = Database.insert(app, false);
        Test.stopTest();
        // Insert may be blocked by the submit validation rule when present; if saved, no collateral means High.
        if (sr.isSuccess()) {
            Loan_Application__c r = [SELECT Risk_Band__c FROM Loan_Application__c WHERE Id = :app.Id];
            System.assertEquals('High', r.Risk_Band__c, 'No collateral on insert should band High');
        } else {
            System.assert(!sr.getErrors().isEmpty(), 'Expected a validation error');
        }
    }

    @isTest
    static void testCalculateRiskBandDirect() {
        System.assertEquals('High', LoanRiskService.calculateRiskBand(null, 500, 1000), 'null dscr');
        System.assertEquals('High', LoanRiskService.calculateRiskBand(1.19, 500, 1000), 'dscr below 1.20');
        System.assertEquals('High', LoanRiskService.calculateRiskBand(1.6, 500, null), 'null collateral');
        System.assertEquals('High', LoanRiskService.calculateRiskBand(1.6, 500, 0), 'zero collateral');
        System.assertEquals('High', LoanRiskService.calculateRiskBand(1.6, 500, -10), 'negative collateral');
        System.assertEquals('High', LoanRiskService.calculateRiskBand(1.6, null, 1000), 'null amount');
        System.assertEquals('High', LoanRiskService.calculateRiskBand(1.6, 851, 1000), 'ratio above 0.85');
        System.assertEquals('Medium', LoanRiskService.calculateRiskBand(1.2, 850, 1000), 'boundary 1.20 / 0.85 is Medium');
        System.assertEquals('Low', LoanRiskService.calculateRiskBand(1.5, 600, 1000), 'boundary 1.50 / 0.60 is Low');
        System.assertEquals('Medium', LoanRiskService.calculateRiskBand(1.49, 500, 1000), 'dscr below 1.50 is Medium');
        System.assertEquals('Medium', LoanRiskService.calculateRiskBand(1.6, 700, 1000), 'ratio above 0.60 is Medium');
    }

    @isTest
    static void testApplyRiskBandsNullSafe() {
        LoanRiskService.applyRiskBands(null, null);
        List<Loan_Application__c> empty = new List<Loan_Application__c>();
        LoanRiskService.applyRiskBands(empty, null);
        Loan_Application__c a = new Loan_Application__c(Status__c = 'Submitted');
        LoanRiskService.applyRiskBands(new List<Loan_Application__c>{ a }, null);
        System.assertEquals('High', a.Risk_Band__c, 'Unsaved submitted app with no data bands High');
        Loan_Application__c b = new Loan_Application__c(Status__c = 'Draft');
        LoanRiskService.applyRiskBands(new List<Loan_Application__c>{ b }, new Map<Id, Loan_Application__c>());
        System.assertEquals(null, b.Risk_Band__c, 'Draft app is not banded');
    }
}