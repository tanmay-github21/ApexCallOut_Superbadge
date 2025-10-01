@isTest
global class BillingCalloutServiceMock implements WebServiceMock {
//mock test class for the BillingServiceProxy and AccessibilityProjectBilling  class 

    global void doInvoke(object stub, 
                         object request, 
                         Map<string,Object>response,
                         String endPoint,
                         String soapAction,
                         String requestName,
                         String responseNS,
                         String responseName, String responseType){
                             
        BillingServiceProxy.billProjectResponse_element resp= new BillingServiceProxy.billProjectResponse_element(); 
        resp.status='Success -Project Built';
        response.put('response_x',resp);                     
    }
}