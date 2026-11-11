@isTest
private class LT15S_HttpBinClientTest {
    private class MockResp implements HttpCalloutMock {
        Integer code; String status; String body;
        MockResp(Integer code, String status, String body) {
            this.code = code; this.status = status; this.body = body;
        }
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(code);
            res.setStatus(status);
            res.setBody(body);
            return res;
        }
    }

    @isTest
    static void ok200() {
        Test.setMock(HttpCalloutMock.class, new MockResp(200, 'OK', '{"args":{"requestId":"abc"},"origin":"1.2.3.4"}'));
        Test.startTest();
        LT15S_HttpBinClient.Result r = LT15S_HttpBinClient.lookup('abc');
        Test.stopTest();
        System.assertEquals(true, r.success, 'should succeed');
        System.assertEquals(200, r.statusCode, 'status');
        System.assertEquals('1.2.3.4', r.origin, 'origin');
        System.assertEquals('abc', r.requestId, 'request id');
    }

    @isTest
    static void err500() {
        Test.setMock(HttpCalloutMock.class, new MockResp(500, 'Server Error', 'oops'));
        Test.startTest();
        LT15S_HttpBinClient.Result r = LT15S_HttpBinClient.lookup('abc');
        Test.stopTest();
        System.assertEquals(false, r.success, 'should fail');
        System.assertEquals(500, r.statusCode, 'status');
        System.assertNotEquals(null, r.error, 'error text');
    }

    @isTest
    static void malformed() {
        Test.setMock(HttpCalloutMock.class, new MockResp(200, 'OK', 'not json'));
        Test.startTest();
        LT15S_HttpBinClient.Result r = LT15S_HttpBinClient.lookup('abc');
        Test.stopTest();
        System.assertEquals(false, r.success, 'should fail');
        System.assertNotEquals(null, r.error, 'error text');
    }

    @isTest
    static void queueable() {
        Test.setMock(HttpCalloutMock.class, new MockResp(200, 'OK', '{"args":{"requestId":"q1"},"origin":"9.9.9.9"}'));
        LT15S_HttpBinJob job = new LT15S_HttpBinJob('q1');
        System.assertEquals('q1', job.requestId, 'getter');
        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();
        List<LT15S_Lookup_Log__c> logs = [SELECT LT15S_Request_Id__c, LT15S_Status_Code__c, LT15S_Origin__c FROM LT15S_Lookup_Log__c WHERE LT15S_Request_Id__c = 'q1'];
        System.assertEquals(1, logs.size(), 'one log');
        System.assertEquals(200, logs[0].LT15S_Status_Code__c, 'status');
        System.assertEquals('9.9.9.9', logs[0].LT15S_Origin__c, 'origin');
    }
}