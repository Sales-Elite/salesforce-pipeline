public with sharing class RenewalRiskScoringBatch implements Database.Batchable<SObject>, Database.Stateful {

    @TestVisible private List<String> failures = new List<String>();

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [SELECT Id FROM Account
             WHERE Id IN (SELECT Account__c FROM Renewal__c
                          WHERE Status__c != 'Renewed' AND Status__c != 'Churned')
             WITH USER_MODE]
        );
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        Set<Id> accIds = new Map<Id, Account>(scope).keySet();

        // (1) open high-priority cases per account
        Set<String> priorities = getHighPriorityValues();
        Map<Id, Integer> caseCounts = new Map<Id, Integer>();
        for (AggregateResult ar : [SELECT AccountId acc, COUNT(Id) cnt FROM Case
                                   WHERE AccountId IN :accIds AND IsClosed = false
                                   AND Priority IN :priorities
                                   WITH USER_MODE
                                   GROUP BY AccountId]) {
            caseCounts.put((Id) ar.get('acc'), Integer.valueOf(ar.get('cnt')));
        }

        // (2) most recent logged activity per account (Tasks and Events on the Account itself)
        Map<Id, Date> lastActivity = new Map<Id, Date>();
        for (Task t : [SELECT WhatId, ActivityDate, CreatedDate FROM Task
                       WHERE WhatId IN :accIds AND IsClosed = true
                       WITH USER_MODE]) {
            Date d = t.ActivityDate != null ? t.ActivityDate : t.CreatedDate.date();
            track(lastActivity, t.WhatId, d);
        }
        Date today = Date.today();
        for (Event e : [SELECT WhatId, ActivityDate FROM Event
                        WHERE WhatId IN :accIds AND ActivityDate != null AND ActivityDate <= :today
                        WITH USER_MODE]) {
            track(lastActivity, e.WhatId, e.ActivityDate);
        }

        // (5) update open renewals whose level changed, skipping manually set ones
        List<Renewal__c> toUpdate = new List<Renewal__c>();
        for (Renewal__c r : [SELECT Id, Account__c, Risk_Level__c, Risk_Level_Set_Manually__c FROM Renewal__c
                             WHERE Account__c IN :accIds
                             AND Status__c != 'Renewed' AND Status__c != 'Churned'
                             WITH USER_MODE]) {
            if (r.Risk_Level_Set_Manually__c == true) {
                continue;
            }
            Integer cases = caseCounts.containsKey(r.Account__c) ? caseCounts.get(r.Account__c) : 0;
            Date last = lastActivity.get(r.Account__c);
            Integer days = last == null ? null : last.daysBetween(today);
            String level = calculateRiskLevel(cases, days);
            if (r.Risk_Level__c != level) {
                toUpdate.add(new Renewal__c(Id = r.Id, Risk_Level__c = level));
            }
        }
        applyUpdates(toUpdate);
    }

    @TestVisible
    private void applyUpdates(List<Renewal__c> toUpdate) {
        if (toUpdate == null || toUpdate.isEmpty()) {
            return;
        }
        List<Database.SaveResult> results = Database.update(toUpdate, false, AccessLevel.USER_MODE);
        for (Integer i = 0; i < results.size(); i++) {
            if (!results[i].isSuccess()) {
                List<String> msgs = new List<String>();
                for (Database.Error err : results[i].getErrors()) {
                    msgs.add(err.getMessage());
                }
                String line = toUpdate[i].Id + ': ' + String.join(msgs, '; ');
                failures.add(line);
                System.debug(LoggingLevel.ERROR, 'Renewal risk update failed - ' + line);
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        if (failures.isEmpty()) {
            return;
        }
        String email;
        for (AsyncApexJob j : [SELECT CreatedBy.Email FROM AsyncApexJob
                               WHERE Id = :bc.getJobId() WITH USER_MODE]) {
            email = j.CreatedBy.Email;
        }
        sendFailureReport(email);
    }

    @TestVisible
    private void sendFailureReport(String email) {
        if (String.isBlank(email) || failures.isEmpty()) {
            return;
        }
        Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
        m.setToAddresses(new List<String>{ email });
        m.setSubject('Renewal risk scoring: ' + failures.size() + ' update(s) failed');
        m.setPlainTextBody('These renewals could not be updated:\n\n' + String.join(failures, '\n'));
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ m });
    }

    /**
     * daysSinceLastActivity null means no logged activity at all (beyond every day threshold).
     */
    public static String calculateRiskLevel(Integer openHighCases, Integer daysSinceLastActivity) {
        Integer cases = openHighCases == null ? 0 : openHighCases;
        for (Risk_Threshold__mdt t : loadThresholds()) {
            Boolean casesMet = t.Open_High_Priority_Cases__c != null
                && cases >= t.Open_High_Priority_Cases__c;
            Boolean daysMet = t.Days_Since_Last_Activity__c != null
                && (daysSinceLastActivity == null || daysSinceLastActivity > t.Days_Since_Last_Activity__c);
            if (casesMet || daysMet) {
                return t.DeveloperName;
            }
        }
        return 'Low';
    }

    private static List<Risk_Threshold__mdt> loadThresholds() {
        List<Risk_Threshold__mdt> result = new List<Risk_Threshold__mdt>();
        for (Risk_Threshold__mdt t : [SELECT DeveloperName, Open_High_Priority_Cases__c,
                                             Days_Since_Last_Activity__c, Evaluation_Order__c
                                      FROM Risk_Threshold__mdt
                                      WHERE DeveloperName IN ('High', 'Medium')
                                      WITH USER_MODE
                                      ORDER BY Evaluation_Order__c ASC]) {
            result.add(t);
        }
        return result;
    }

    private static Set<String> getHighPriorityValues() {
        Set<String> vals = new Set<String>();
        for (Risk_Scoring_Setting__mdt s : [SELECT High_Priority_Case_Values__c
                                            FROM Risk_Scoring_Setting__mdt WITH USER_MODE]) {
            if (String.isNotBlank(s.High_Priority_Case_Values__c)) {
                for (String v : s.High_Priority_Case_Values__c.split(',')) {
                    if (String.isNotBlank(v.trim())) {
                        vals.add(v.trim());
                    }
                }
            }
        }
        if (vals.isEmpty()) {
            vals.add('High');
        }
        return vals;
    }

    private static void track(Map<Id, Date> m, Id accId, Date d) {
        if (d == null) {
            return;
        }
        Date cur = m.get(accId);
        if (cur == null || d > cur) {
            m.put(accId, d);
        }
    }
}