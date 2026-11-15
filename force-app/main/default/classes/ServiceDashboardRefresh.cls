public with sharing class ServiceDashboardRefresh {
    @InvocableMethod(label='Refresh Service Manager dashboard' description='Refreshes the Service Manager Overview dashboard')
    public static void refresh(List<String> dashboardDeveloperNames) {
        if (dashboardDeveloperNames == null || dashboardDeveloperNames.isEmpty()) {
            return;
        }
        System.enqueueJob(new RefreshJob(dashboardDeveloperNames));
    }

    @TestVisible
    private static Integer callRefresh(String dashboardId, String devName) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Service_Dashboard_Self/services/data/v62.0/analytics/dashboards/' + dashboardId);
        req.setMethod('PUT');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{}');
        HttpResponse res = new Http().send(req);
        Integer code = res.getStatusCode();
        if (code < 200 || code > 299) {
            System.debug(LoggingLevel.ERROR, 'ServiceDashboardRefresh failed for ' + devName + ': ' + code + ' ' + res.getBody());
        }
        return code;
    }

    public class RefreshJob implements Queueable, Database.AllowsCallouts {
        private List<String> names;
        public RefreshJob(List<String> names) {
            this.names = names;
        }
        public void execute(QueueableContext ctx) {
            try {
                List<Dashboard> dashboards = [SELECT Id, DeveloperName FROM Dashboard WHERE DeveloperName IN :names WITH USER_MODE];
                if (dashboards.isEmpty()) {
                    System.debug(LoggingLevel.WARN, 'ServiceDashboardRefresh: no dashboard found for ' + names);
                    return;
                }
                for (Dashboard d : dashboards) {
                    callRefresh(d.Id, d.DeveloperName);
                }
            } catch (Exception e) {
                System.debug(LoggingLevel.ERROR, 'ServiceDashboardRefresh error: ' + e.getMessage());
            }
        }
    }
}