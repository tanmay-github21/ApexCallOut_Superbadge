public class RewardsCalloutService{

    public static Integer submitUsersForRewardCallout(String jsonBody) {
        //Set Endpoint from Named Credential
        SYstem.debug('Inside RewardsCallOutService class');
        Http http= new Http();
        HttpRequest request= new HttpRequest(); 
        integer statusCode=0;
        system.debug('Size of the request string'+'\t'+blob.valueof(jsonBody).size());
        try{
             request.setEndPoint('callout:IntegrationSB__BalancedLiving/rewards');
             System.debug('endpoint has been set');
             request.setMethod('POST');
             request.setHeader('Content-Type', 'application/json;charset=UTF-8');
             request.setBody(jsonBody);
             //Check for the number of times endpoint is being hit 
             SYstem.debug('Callouts used before sending'+'\t'+limits.getCallOuts());
             integer made=limits.getCallOuts(), total=limits.getLimitCallouts(), remaining=total-made;
             SYstem.debug('Total Callout'+'\t'+total+'\t'+'Callouts made'+'\t'+made+'\t'+'remaining callouts'+'\t'+remaining);
             HttpResponse response= http.send(request);

             statusCode=response.getStatusCode();
             system.debug('status code'+'\t'+statusCode);
             if(statusCode == 201)
                 System.debug('Endpoint Hit');
            else throw new CalloutException('Unexpected status code'+'\t'+statusCode+'\n'+
                                           'Body'+'\t'+response.getBody());
        }
        catch(System.callOutException ex){
            System.debug('Catch Block CallOutException'+'\t'+ex.getMessage());
        }
        catch(exception e){
            system.debug('General Exception'+'\t'+e.getMessage());
        }
        return statusCode;
    }
}