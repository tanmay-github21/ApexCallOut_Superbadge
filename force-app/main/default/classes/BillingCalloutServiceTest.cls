@isTest
private class BillingCalloutServiceTest {
//mock test class for the BillingServiceProxy and AccessibilityProjectBilling  class 
	@isTest
	static void testProjectBuiltSuccess(){
        test.setMock(webserviceMock.class, new BillingCalloutServiceMock());
        
    }
}