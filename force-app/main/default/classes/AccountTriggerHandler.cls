public with sharing class AccountTriggerHandler {
    public static void setLt2Flag(List<Account> newAccounts) {
        for (Account a : newAccounts) {
            a.LT2_Flag__c = (a.Rating == 'Hot');
        }
    }
}