public with sharing class RenewalRiskScheduler implements Schedulable {
    public static final String CRON_EXPR = '0 0 2 * * ?';
    public static final String JOB_NAME = 'Nightly Renewal Risk Scoring';

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new RenewalRiskScoringBatch(), 200);
    }

    public static Id scheduleNightly() {
        return System.schedule(JOB_NAME, CRON_EXPR, new RenewalRiskScheduler());
    }
}