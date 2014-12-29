/**
  *     Description    :    HTTP Request Builder.
  *
  *     Created By     :    Subhash Garhwal
  *
  *     Created Date   :    07/07/2014
  *
  *     Revision Log   :    V_1.0 Created.
  *
**/
global with sharing class HTTPRequestBuilder {

	//Method for HTTP Callout for Getting Sobject Id
	webservice static String getSObjectId(String objName) {
		
		//Get Salesforce Base URL
        String salesforceURL = URL.getSalesforceBaseURL().toExternalForm();
		
		//Http Request
        HttpRequest req = new HttpRequest();
        
        //Set Header
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        
        //Create Tooling API String
        String toolingendpoint = salesforceURL + '/services/data/v30.0/tooling/';
        
        //Check for object Type
        if(objName == Constants.QF_CUSTOM_OBJECT)
        	toolingendpoint += 'query/?q=select+id,DeveloperName+from+'+ objName +'';
        else
        	toolingendpoint += 'query/?q=select+id,TableEnumOrId,DeveloperName+from+'+ objName +'';
        req.setEndpoint(toolingendpoint);
        req.setMethod('GET');
            
        //Http
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        //Return response
        return res.getBody();
	}
	
	//Method for HTTP Callout for Getting Custom Object Id Related To Custom Field
	webservice static String getCustomObjectId(String recordId) {
		
		//Get Salesforce Base URL
        String salesforceURL = URL.getSalesforceBaseURL().toExternalForm();
		
		//Http Request
        HttpRequest requ = new HttpRequest();
        
        //Set Header
        requ.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        requ.setHeader('Content-Type', 'application/json');
        
        //Create Tooling API String
        String toolingPt = salesforceURL + '/services/data/v30.0/tooling/';
        
        //Query for custom fields
        toolingPt += 'query/?q=select+id,DeveloperName+from+CustomObject+Where+Id=\'' + recordId + '\'';
        requ.setEndpoint(toolingPt);
        requ.setMethod('GET');
        
        //Http
        Http hh = new Http();
        HttpResponse resq = hh.send(requ);
        
        //Return response
        return resq.getBody();
	}
}