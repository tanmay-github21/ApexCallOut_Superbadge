@isTest
private class BillingCalloutServiceTest {
//mock test class for the BillingServiceProxy and AccessibilityProjectBilling  class 
	@isTest
	static void testProjectBuiltSuccess(){
        SYstem.debug('test method testProjectBuiltSuccess');
        test.setMock(WebServiceMock.class, new BillingCalloutServiceMock(BillingCalloutServiceMock.ResponseType.SUCCESS));
        BillingServiceProxy.InvoicesPortSoap11 soapClient=new BillingServiceProxy.InvoicesPortSoap11();
        BillingServiceProxy.project projRequest= new BillingServiceProxy.project();
        projRequest.projectid='PRJ-00458';
        projRequest.billAmount=50.00;
        projRequest.username='dummyuser';
        projRequest.password='dummypassword';
        test.startTest();
        string status = soapClient.billProject(projRequest);
        test.stopTest();
		system.assert(status.contains('SUCCESS'),'BillingCallout It should be success but no success');
    }
    
    @isTest
    static void testProjectBuiltFailure(){
        System.debug('test method testProjectBuiltFailure');
        test.setMock(WebServiceMock.class, new BillingCalloutServiceMock(BillingCalloutServiceMock.ResponseType.ERROR));
        BillingServiceProxy.InvoicesPortSoap11 soapClient=new BillingServiceProxy.InvoicesPortSoap11();
        BillingServiceProxy.project projRequest= new BillingServiceProxy.project();
        projRequest.projectid='PRJ-00459';
        projRequest.billAmount= -75.57;
        projRequest.username='dummyuser';
        projRequest.password='dummypassword';
        test.startTest();
        string status = soapClient.billProject(projRequest);
        test.stopTest();
		system.assert(status.contains('ERROR'),'BillingCallout It should be error but no error');
    }
    /*@isTest
    static void testAccessibility_FutureCalloutSuccess(){
        test.setMock(WebServiceMock.class, new BillingCalloutServiceMock(BillingCalloutServiceMock.ResponseType.SUCCESS));
        test.startTest();
        AccessibilityProjectBilling.callBillingService('Proj-123', 85.25);
        test.stopTest(); 
        System.assertEquals(true,limits.getFutureCalls()>0, 'Future method should have executed');
    }
    
    @isTest
    static void testAccessibility_FutureCalloutError(){
        test.setMock(WebServiceMock.class, new BillingCalloutServiceMock(BillingCalloutServiceMock.ResponseType.ERROR));
        test.startTest();
        AccessibilityProjectBilling.callBillingService('Proj-123', 85.25);
        test.stopTest(); 
        System.assertEquals(true,limits.getFutureCalls()>0, 'Future method executed with an error');
    }
    
    @isTest
    static void testAsyncBillingProxyError(){
        test.setMock(WebServiceMock.class, new BillingCalloutServiceMock(BillingCalloutServiceMock.ResponseType.ERROR));
        billingserviceproxy.project projectRequest=new billingserviceproxy.project(); 
        projectRequest.username='dummyusername';
        projectRequest.password='dummypassword';
        projectRequest.projectid='Proj-1234';
        projectRequest.billAmount=89.34;
        system.continuation cont=new system.continuation(60);
        test.startTest();
        AsyncBillingServiceProxy.AsyncInvoicesPortSoap11 client=new AsyncBillingServiceProxy.AsyncInvoicesPortSoap11();
        AsyncBillingServiceProxy.billProjectResponse_elementFuture futuree= client.beginBillProject(cont, projectRequest);
        test.stopTest();
        //System.assertNotEqual(null, futuree, 'Future reponse object shouldnt be null');
    }*/
}