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
@isTest(seeAllData=False)
//Mock Class implement the interface
global class SearchRecordsMock implements HttpCalloutMock {
/*
 *	Purpose        :    Mock class for SearchRecords
 *       
 *	Created By     :    Subhash Garhwal
 * 
 *	Created Date   :    05/15/2014
 * 
 *	Revision Log   :    V_1.0 - Created                  
 */
    //Implement the interface method
    global HTTPResponse respond(HTTPRequest req) {

        //Create a fake HTTP Response
        HttpResponse response = new HttpResponse();
        
        //Set the value of header
        response.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        response.setHeader('Content-Type', 'application/json');
        
        //Set the value of body
        response.setBody('{"size":3,"totalSize":3,"done":true,"queryLocator":null,"entityTypeName":"CustomEntityDefinition","records":[{"attributes":{"type":"CustomObject","url":"/services/data/v30.0/tooling/sobjects/CustomObject/01I900000005omfEAA"},"Id":"01I900000005omfEAA","DeveloperName":"Property"},{"attributes":{"type":"CustomObject","url":"/services/data/v30.0/tooling/sobjects/CustomObject/01I900000005omkEAA"},"Id":"01I900000005omkEAA","DeveloperName":"Pipeline"},{"attributes":{"type":"CustomObject","url":"/services/data/v30.0/tooling/sobjects/CustomObject/01I900000005oo7EAA"},"Id":"01I900000005oo7EAA","DeveloperName":"Prospect"}]}');
        
        //Set the status code
        response.setStatusCode(200);
        
        //Return the response
        return response;
    }
}