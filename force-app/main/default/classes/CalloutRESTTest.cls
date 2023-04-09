@isTest
public class CalloutRESTTest {
    
    
    @isTest
    static void restTest() {
        Test.startTest();

        // Again we start similarly, we set the mock
        Test.SetMock(HttpCalloutMock.class, new MockRest());

        HTTP send = new HTTP();

        // Then it's just a matter of making the callout
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/');
        request.setMethod('GET');

        HTTPResponse response = send.send(request);

        Test.stopTest();

        Assert.isEqual('{"message":"Success!"}', response.getBody());
    }

    @isTest
    static soapTest() {
        Test.startTest();

        Test.setMock(WebServiceMock.class, new SoapMock());

        SampleWSDLClass.requestInfo = new SampleWSDLClass.helloRequest();
        SampleWSDLClass.HelloEndpointPort request = new SampleWSDLClass.HelloEndpointPort();
        SampleWSDLClass.helloResponse response = request.sayHello(requestInfo);

        Test.stopTest();

        Assert.isEqual('Hello World!', response.Message);
    }
}