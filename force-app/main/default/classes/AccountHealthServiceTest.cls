@isTest
private class AccountHealthServiceTest {

    @isTest
    static void countsOnlyOpenCasesForAccount() {
        Account target = new Account(Name = 'Target Account');
        Account other = new Account(Name = 'Other Account');
        insert new List<Account>{ target, other };

        CaseStatus closedStatus = [SELECT MasterLabel FROM CaseStatus WHERE IsClosed = true LIMIT 1];
        CaseStatus openStatus = [SELECT MasterLabel FROM CaseStatus WHERE IsClosed = false LIMIT 1];

        List<Case> cases = new List<Case>{
            new Case(AccountId = target.Id, Status = openStatus.MasterLabel, Origin = 'Web'),
            new Case(AccountId = target.Id, Status = openStatus.MasterLabel, Origin = 'Web'),
            new Case(AccountId = target.Id, Status = closedStatus.MasterLabel, Origin = 'Web'),
            new Case(AccountId = other.Id, Status = openStatus.MasterLabel, Origin = 'Web')
        };
        insert cases;

        Test.startTest();
        Integer result = AccountHealthService.countOpenCases(target.Id);
        Integer otherResult = AccountHealthService.countOpenCases(other.Id);
        Test.stopTest();

        Assert.areEqual(2, result, 'Only the 2 open Cases of the target Account should be counted; closed and other-account Cases excluded');
        Assert.areEqual(1, otherResult, 'The other Account has exactly 1 open Case');
    }

    @isTest
    static void returnsZeroWhenNoOpenCases() {
        Account a = new Account(Name = 'No Cases Account');
        insert a;

        Assert.areEqual(0, AccountHealthService.countOpenCases(a.Id), 'An Account with no Cases should return 0');
    }

    @isTest
    static void returnsZeroForNullId() {
        Assert.areEqual(0, AccountHealthService.countOpenCases(null), 'A null Account Id should return 0');
    }
}