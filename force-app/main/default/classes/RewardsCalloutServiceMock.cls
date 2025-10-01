@isTest
global class RewardsCalloutServiceMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response= new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        string  body=request.getBody(), method=request.getMethod();
        System.debug('Mock Class Body'+'\t'+body);
        //400 error code
        if(body.contains('400')){
            response.setStatusCode(400);
            response.setBody('{"code":400,"description":"Bad Request"}');
            System.debug('400 mock status code'+'\t'+response.getStatusCode()+'\n'+
                        '400 mock Body'+'\t'+response.getBody());
        }
        
        //500 error code
         if(body.contains('500')){
            response.setStatusCode(500);
            response.setBody('{"code":500,"description":"Bad Request"}');
            System.debug('500 mock status code'+'\t'+response.getStatusCode()+'\n'+
                        '500 mock body'+'\t'+response.getBody()); 
        }
         //200 error code for Get
         if(body.contains('200')) {
            response.setStatusCode(200);
			response.setBody('{"status":"Great", "recommendation":"Using reminders can help to improve it further"}');
            System.debug('200 mock status code'+'\t'+response.getStatusCode()+'\n'+
                        '200 mock body'+'\t'+response.getBody()); 
        }
        //201 error code for POST
        if(body.contains('201')){
            response.setStatusCode(201);
            response.setBody('{"message":"Success"}');
            SYstem.debug('201 mock status code'+'\t'+response.getStatusCode());
                
        }
        return response; 
    }
}