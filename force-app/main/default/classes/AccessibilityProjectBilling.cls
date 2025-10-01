global class AccessibilityProjectBilling{
   
   @future(callout=true) 
   public static void callBillingService(String projectId, Decimal billingAmount){
        //Setup username, password, billAmount, and projectid in BillingServiceProxy.project and then call billProject method

         //If response is ok set Accessibility Project Status = Complete
         try{
               BillingServiceProxy proxy= new BillingServiceProxy();
               BillingServiceproxy.project request= new BillingServiceproxy.project();
			   //string response=proxy.billProjectRequest_element
               request.username='{!$Credential.BillingServiceCredential.username}';
               request.password='{!$Credential.BillingServiceCredential.password}'; 
               request.projectid=string.valueof(projectId);
               request.billAmount=double.valueof(billingAmount);
			   //calling the endpoint 
			   BillingServiceProxy.InvoicesPortSoap11 invoicePort= new BillingServiceProxy.InvoicesPortSoap11();
               invoicePort.endpoint_x='callout:IntegrationSB__BillingInvoiceService'; 
               string status=invoicePort.billProject(request);
               system.debug('Status returned from endpoint'+'\t'+status);
         }
         catch(exception e){
             
         }		
         
         
    }
}