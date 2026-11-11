public with sharing class LT15S_HttpBinClient {
    public class Result {
        @AuraEnabled public Integer statusCode;
        @AuraEnabled public String origin;
        @AuraEnabled public String requestId;
        @AuraEnabled public String error;
        @AuraEnabled public Boolean success = false;
    }

    public static Result lookup(String requestId) {
        Result r = new Result();
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:LT15S_HttpBin/get?requestId=' + EncodingUtil.urlEncode(requestId == null ? '' : requestId, 'UTF-8'));
            req.setMethod('GET');
            req.setTimeout(10000);
            HttpResponse res = new Http().send(req);
            r.statusCode = res.getStatusCode();
            if (res.getStatusCode() != 200) {
                r.error = 'HTTP ' + res.getStatusCode() + ' ' + res.getStatus();
                return r;
            }
            Map<String, Object> body = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            r.origin = (String) body.get('origin');
            Object args = body.get('args');
            if (args instanceof Map<String, Object>) {
                r.requestId = (String) ((Map<String, Object>) args).get('requestId');
            }
            r.success = true;
        } catch (Exception e) {
            r.error = e.getMessage();
            r.success = false;
        }
        return r;
    }
}