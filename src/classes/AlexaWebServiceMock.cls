/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
 /**
 *  Description     :   Mock Class for AlexaRankWebServiceController
 *
 *  Created Date    :   06/12/2013
 *
 *  Revision Logs   :   V1.0 - Created  
 * 
 * Coverage         :                    
 **/
@isTest(seeAllData=false)
//Mock Class implement the interface
global class AlexaWebServiceMock implements HttpCalloutMock {
	
	//Boolean variable for deciding the body of response
	public static Boolean isValidResponse {get; set;}

    //Implement the interface method
    global HTTPResponse respond(HTTPRequest req) {

        //Create a fake HTTP Response
        HttpResponse response = new HttpResponse();
        
        //Set the value of header
        response.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        //Check if valid response is there
        if(AlexaWebServiceMock.isValidResponse == true) {
        
	        //Set the value of body
	        response.setBody('{'
							 + '"status":"OK",'
							 + '"url":"salesforce.com",'
							 + '"rank":"353",'
							 + '"countries":'
							 + '{'
							 + '"in":794,"sg":313,"ru":3056,"il":54,"uk":2000,"es":1357,"us":134,"hk":310,"ie":94,"au":275,"gb":284,"fr":2484,"br":1084,"za":613,"mx":991,'
							 + '"dk":50,"nl":279,"ca":297,"jp":1006,"cn":3191,"o":0,"de":940'
							 + '}'
							 + '}'); 
        } else {
        	
        	response.setBody('{'
							 + '"status":"ERROR",'
							 + '"url":"404",'
							 + '"rank":"",'
							 + '"countries":'
							 + '{'
							 + '}'
							 + '}');
        }    
       
        //Set the status code
        response.setStatusCode(200);
        
        //Return the response
        return response;
    }
}