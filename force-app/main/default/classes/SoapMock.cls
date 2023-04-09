public class SoapMock implements WebServiceMock {
    
    public void doInvoke(   Object stub, Object request, Map<String, Object> response,
                            String endpoint, String soapAction, String requestName,
                            String responseNamespace, String responseName, String responseType) {

        SampleWSDLClass.SayHelloResponse myResponse = new SampleWSDLClass.SayHelloResponse();
        myResponse.HelloResponse = new SampleWSDLClass.HelloResponse();
        myResponse.HelloResponse.Message = 'Hello world!';
        response.put('response_x', myResponse);
    }
}