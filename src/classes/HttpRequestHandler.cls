/**
 *  Description	:	This class is to handle all the HTTP callouts
 * 
 *  Revision Logs:  V1.0 - Created
 **/
public with sharing class HttpRequestHandler {

	//Variable to hold the Configuartion Manager
	public static Configuration_Manager__c config = Constants.CONFIGURATION_MANAGER;

	//This method is to make the webservice callouts
	public static DOM.Document makeHTTPCallout(String soapEnvelope) {
		
		//Create a HTTP Request
		HttpRequest req = new HttpRequest();
		
		//Set Endpoint URL
		req.setEndpoint(config.Bronto_Endpoint_URL__c);
		
		//Set Method type
		req.setMethod('GET');
		
		//set header
		req.setHeader('Content-Type', 'application/soap+xml');
		req.setHeader('charset', 'UTF-8');
		
		//Set Body
		req.setBody(soapEnvelope);
		
		//Timeout
		req.setTimeout(60000);
		
		//Make callout
		Http http = new Http();
		
		HttpResponse response;
		
		//check if test method is running, then retura a Mock response
		if(Test.isRunningTest()) {
			
			//Create mock response
			HttpRequestHandlerMockClass mockResponse = new HttpRequestHandlerMockClass();
			response = mockResponse.respond(req);
			
		} else {
		
			//Http Response 
			response = http.send(req);
		}
		 	
		//Return Response as argument
		return response.getBodyDocument();
	}
	
	//This method is to make the webservice callouts for Update
	public static DOM.Document makeHTTPCalloutForUpdate(String soapEnvelope) {
		
		//Create a HTTP Request
		HttpRequest req = new HttpRequest();
		
		//Set Endpoint URL
		req.setEndpoint(config.Bronto_Endpoint_URL__c);
		
		//Set Method type
		req.setMethod('POST');
		
		//set header
		req.setHeader('Content-Type', 'text/xml');
		req.setHeader('charset', 'UTF-8');
		
		//Set Body
		req.setBody(soapEnvelope);
		
		//Timeout
		req.setTimeout(60000);
		
		//Make callout
		Http http = new Http();
		
		HttpResponse response;
		
		//check if test method is running, then retura a Mock response
		if(Test.isRunningTest()) {
			
			//Create mock response
			HttpRequestHandlerMockClass mockResponse = new HttpRequestHandlerMockClass();
			response = mockResponse.respondUpdateContact(req);
		
		} else {
			
			//Http Response 
			response = http.send(req);
		}
		 	
		//Return Response as argument
		return response.getBodyDocument();
	}
}