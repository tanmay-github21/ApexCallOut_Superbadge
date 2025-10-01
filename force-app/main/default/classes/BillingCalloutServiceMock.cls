@isTest
global class BillingCalloutServiceMock implements WebServiceMock {
//mock test class for the BillingServiceProxy and AccessibilityProjectBilling  class 

    public enum ResponseType{SUCCESS, ERROR}
    private ResponseType type;
    public BillingCalloutServiceMock(ResponseType responseType){
        this.type=responseType;
    }
    
    global void doInvoke(object stub, 
                         object request, 
                         Map<string,Object>response,
                         String endPoint,
                         String soapAction,
                         String requestName,
                         String responseNS,
                         String responseName, String dummyString){
                             
        if(type ==ResponseType.SUCCESS){
            System.debug('BillingCallOutMock Response Is Successfull');
            BillingServiceProxy.billProjectResponse_element resp= new BillingServiceProxy.billProjectResponse_element();
            resp.status='Success: Project billed!';
            response.put('response_x',resp);
        }
        else {
            System.debug('BillingCallOutMock Response Failed');
            BillingServiceProxy.billProjectResponse_element resp=new BillingServiceProxy.billProjectResponse_element();
            resp.status='Error: Invalid project';
            response.put('response_x',resp);
        }                     
    } //doInit end of method
}