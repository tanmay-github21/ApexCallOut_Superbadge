@isTest
global class RewardsCalloutServiceMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response= new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        if(request.getEndpoint().contains('Success')){
            response.setStatusCode(200);
            response.setBody('{"status":"Great", "recommendation":"Using reminders can help to improve it further."}');
        }
        else if(request.getEndPoint().contains('Bad Request')){
            response.setStatusCode(400);
            response.setBody('{"description":"Bad Request"}');
        }
        else if(request.getEndPoint().contains('Internal Server Error')){
            response.setStatusCode(500);
            response.setBody('{"example":"Internal Server Error"}');
        }
        return response; 
    }
}