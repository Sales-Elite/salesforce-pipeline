public with sharing class MCPN_OrderSignalHandler {
    public static void handleAfterInsert(List<MCPN_Order_Signal__e> events) {
        Set<Id> ids = new Set<Id>();
        for (MCPN_Order_Signal__e e : events) {
            if (String.isBlank(e.Account_Id__c)) { continue; }
            try {
                ids.add(Id.valueOf(e.Account_Id__c.trim()));
            } catch (Exception ex) {
                continue;
            }
        }
        if (ids.isEmpty()) { return; }
        Map<Id, Account> accts = new Map<Id, Account>([SELECT Id FROM Account WHERE Id IN :ids WITH USER_MODE]);
        List<Task> tasks = new List<Task>();
        for (MCPN_Order_Signal__e e : events) {
            if (String.isBlank(e.Account_Id__c)) { continue; }
            Id aid;
            try {
                aid = Id.valueOf(e.Account_Id__c.trim());
            } catch (Exception ex) {
                continue;
            }
            if (!accts.containsKey(aid)) { continue; }
            Boolean crit = e.Severity__c != null && e.Severity__c.equalsIgnoreCase('critical');
            tasks.add(new Task(
                WhatId = aid,
                Subject = 'Order signal: ' + e.Severity__c,
                Description = e.Message__c,
                Priority = crit ? 'High' : 'Normal',
                Status = 'Not Started'
            ));
        }
        if (!tasks.isEmpty()) {
            Database.insert(tasks, false, AccessLevel.USER_MODE);
        }
    }
}