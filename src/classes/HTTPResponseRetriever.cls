/**
 *  Description     :   This class is to retrieve reposne on the basis of request.
 *
 *  Created Date    :   06/12/2013
 * 
 *  Revision Logs   :   V1.0 - Created
 *
**/
public with sharing class HTTPResponseRetriever {
    
    //method to validate address
    public static HttpResponse doValidate(HttpRequest request) {
        
        //Create a HTTP instance and do callout
        Http http = new Http();
        return  http.send(request);
    }
}