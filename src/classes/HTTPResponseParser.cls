/**
 *  Description     :   This class is there to parse the Alexa web service response for getting rank values.  
 *
 *  Created Date    :   06/12/2013
 * 
 *  Revision Logs   :   V1.0 - Created
 *
**/
public with sharing class HTTPResponseParser {
    
    //Method is to parse the response 
    public static String parseAlexaRankResponse(HttpResponse response) {
        
        //Get statusCode and throw error if it fails
        if(response.getStatusCode() != 200) {
        	throw new CustomException(response.getStatus());
        } 
             
        //get body from response
        String body = response.getBody();
        System.debug('@@@@@@ value in body ' + body);    
        
        //Return response body value
        return body;
    }
}