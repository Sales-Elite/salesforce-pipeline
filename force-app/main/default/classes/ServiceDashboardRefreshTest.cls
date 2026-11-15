@isTest(SeeAllData=false)
private class ServiceDashboardRefreshTest {
    private static final String FAKE_DASHBOARD_ID = 'fake-dashboard-id';

    private class Mock implements HttpCalloutMock {
        Integer code;
        Mock(Integer code) { this.code = code; }
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(code);
            res.setBody('{}');
            return res;
        }
    }

    @isTest
    static void callRefresh200() {
        Test.setMock(HttpCalloutMock.class, new Mock(200));
        Test.startTest();
        Integer code = ServiceDashboardRefresh.callRefresh(FAKE_DASHBOARD_ID, 'X');
        Test.stopTest();
        System.assertEquals(200, code, 'Expected 200');
    }

    @isTest
    static void callRefresh500() {
        Test.setMock(HttpCalloutMock.class, new Mock(500));
        Test.startTest();
        Integer code = ServiceDashboardRefresh.callRefresh(FAKE_DASHBOARD_ID, 'X');
        Test.stopTest();
        System.assertEquals(500, code, 'Expected 500');
    }

    @isTest
    static void invocableMissingDashboard() {
        Test.setMock(HttpCalloutMock.class, new Mock(200));
        Test.startTest();
        ServiceDashboardRefresh.refresh(new List<String>{'Does_Not_Exist_XYZ'});
        ServiceDashboardRefresh.refresh(null);
        Test.stopTest();
        System.assert(true, 'No exception for missing dashboard');
    }
}