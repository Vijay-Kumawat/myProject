@isTest(seeAllData=False)
//Mock Class implement the interface
global class HttpRequestHandlerMockClass implements HttpCalloutMock {
/*
    Purpose        :    Mock class for HttpRequestHandler
        
    Created By     :  
  
    Created Date   :    05/01/2013
  
    Revision Log   :    V1.0 - Created                  
*/
    //Implement the interface method
    global HTTPResponse respond(HTTPRequest req) {
    	
    	Configuration_Manager__c config = Constants.CONFIGURATION_MANAGER; 

        //Create a fake HTTP Response
        HttpResponse response = new HttpResponse();
        
        //Set the value of header
        response.setHeader('Content-Type', 'text/xml');
        
        //Set the value of Body
        response.setBody( '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v4="http://api.bronto.com/v4">'
                        + '<soapenv:Header/>'
                     + '<soapenv:Body>'
                    + '<v4:login>'
                        + '<apiToken>' + config.Bronto_API_Key__c + '</apiToken>'
                      + '</v4:login>'
                     + '</soapenv:Body>'
                + '</soapenv:Envelope>');
        
        //Set the status code
        response.setStatusCode(200);
        
        //Return the response
        return response;
    }
    
    //Implement the interface method
    global HTTPResponse respondUpdateContact(HTTPRequest req) {

        //Create a fake HTTP Response
        HttpResponse response = new HttpResponse();
        
        //Set the value of header
        response.setHeader('Content-Type', 'text/xml');
        
        //Set the value of Body
        response.setBody(  '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v4="http://api.bronto.com/v4">'
                        + '<soapenv:Header>'
                            + '<v4:sessionHeader>'
                                + '<sessionId>12343-434343-45656757</sessionId>'
                            + '</v4:sessionHeader>'
                         + '</soapenv:Header>'
                         + '<soapenv:Body>'
                        + '<v4:updateContacts>'
                               + '<contacts>'
                                  + '<email>salesforce@security.com</email>'
                                  + '<status>UnSub</status>'
                             + '</contacts>'
                            + '</v4:updateContacts>'
                         + '</soapenv:Body>'
                    + '</soapenv:Envelope>');
                    
        //Set the status code
        response.setStatusCode(200);
        
        //Return the response
        return response;
    }
}