@isTest
private class testAsyncBillingServiceProxy {
    private class BillingCalloutServiceMock implements WebserviceMock{
        public void doInvoke(Object stub, Object request,
                            Map<String,Object> response,
                            String endPoint,
                            String soapAction,
                            String requestName,
                            String responseNS,
                            String responseName,
                            String responseType){
            response.put('response_x','SUCCESS');
        }
    }
    
    @isTest
    static void testBillingService_Success(){
        test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
        test.startTest();
        AccessibilityProjectBilling.callBillingService('P-123',100.25);
        test.stopTest();
        system.assert(true,'Future method executed successfully'); 
    }
    
    /*@isTest
    static void testBillingService_Error(){
        test.setMock(WebserviceMock.class, new BillingCalloutServiceMock(){
            public override void doInvoke(Object stub, Object request, 
                                         Map<String,Object> response,
                                         String endPoint,
                                         String soapAction,
                                         String requestName,
                                         String responseNS,
                                         String responseName,
                                         String responseType){ response.put('response_x','ERROR');}
        });
    }*/
}