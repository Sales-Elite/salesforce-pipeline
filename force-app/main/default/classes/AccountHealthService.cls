public with sharing class AccountHealthService {
    public static Integer countOpenCases(Id accountId) {
        if (accountId == null) {
            return 0;
        }
        return [SELECT COUNT() FROM Case WHERE AccountId = :accountId AND IsClosed = false WITH USER_MODE];
    }
}