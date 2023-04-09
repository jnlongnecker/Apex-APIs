
@isTest
public class MockRest implements HttpCalloutMock {
    
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();

        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"message":"Success!"}');
        response.setStatusCode(200);

        return response;
    }
    
}