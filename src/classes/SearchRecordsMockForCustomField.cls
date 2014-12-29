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
global class SearchRecordsMockForCustomField implements HttpCalloutMock {
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
        response.setBody('{"size":25,"totalSize":25,"done":true,"queryLocator":null,"entityTypeName":"CustomFieldDefinition","records":[{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000009POUfEAO"},"Id":"00N90000009POUfEAO","TableEnumOrId":"01I900000005omkEAA","DeveloperName":"Status"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000009POQSEA4"},"Id":"00N90000009POQSEA4","TableEnumOrId":"01I900000005omkEAA","DeveloperName":"Description"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybyEAA"},"Id":"00N90000005mybyEAA","TableEnumOrId":"Case","DeveloperName":"Product"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybzEAA"},"Id":"00N90000005mybzEAA","TableEnumOrId":"Case","DeveloperName":"SLAViolation"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc0EAA"},"Id":"00N90000005myc0EAA","TableEnumOrId":"Contact","DeveloperName":"Languages"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc1EAA"},"Id":"00N90000005myc1EAA","TableEnumOrId":"Contact","DeveloperName":"Level"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc2EAA"},"Id":"00N90000005myc2EAA","TableEnumOrId":"Lead","DeveloperName":"CurrentGenerators"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc3EAA"},"Id":"00N90000005myc3EAA","TableEnumOrId":"Lead","DeveloperName":"NumberofLocations"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc4EAA"},"Id":"00N90000005myc4EAA","TableEnumOrId":"Lead","DeveloperName":"Primary"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc5EAA"},"Id":"00N90000005myc5EAA","TableEnumOrId":"Lead","DeveloperName":"ProductInterest"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc6EAA"},"Id":"00N90000005myc6EAA","TableEnumOrId":"Lead","DeveloperName":"SICCode"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc7EAA"},"Id":"00N90000005myc7EAA","TableEnumOrId":"Opportunity","DeveloperName":"CurrentGenerators"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc8EAA"},"Id":"00N90000005myc8EAA","TableEnumOrId":"Opportunity","DeveloperName":"DeliveryInstallationStatus"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005myc9EAA"},"Id":"00N90000005myc9EAA","TableEnumOrId":"Opportunity","DeveloperName":"MainCompetitors"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mycAEAQ"},"Id":"00N90000005mycAEAQ","TableEnumOrId":"Opportunity","DeveloperName":"OrderNumber"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mycBEAQ"},"Id":"00N90000005mycBEAQ","TableEnumOrId":"Opportunity","DeveloperName":"TrackingNumber"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybpEAA"},"Id":"00N90000005mybpEAA","TableEnumOrId":"Account","DeveloperName":"Active"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybqEAA"},"Id":"00N90000005mybqEAA","TableEnumOrId":"Account","DeveloperName":"CustomerPriority"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybrEAA"},"Id":"00N90000005mybrEAA","TableEnumOrId":"Account","DeveloperName":"NumberofLocations"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybsEAA"},"Id":"00N90000005mybsEAA","TableEnumOrId":"Account","DeveloperName":"SLA"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybtEAA"},"Id":"00N90000005mybtEAA","TableEnumOrId":"Account","DeveloperName":"SLAExpirationDate"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybuEAA"},"Id":"00N90000005mybuEAA","TableEnumOrId":"Account","DeveloperName":"SLASerialNumber"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybvEAA"},"Id":"00N90000005mybvEAA","TableEnumOrId":"Account","DeveloperName":"UpsellOpportunity"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybwEAA"},"Id":"00N90000005mybwEAA","TableEnumOrId":"Case","DeveloperName":"EngineeringReqNumber"},{"attributes":{"type":"CustomField","url":"/services/data/v30.0/tooling/sobjects/CustomField/00N90000005mybxEAA"},"Id":"00N90000005mybxEAA","TableEnumOrId":"Case","DeveloperName":"PotentialLiability"}]}');
        
        //Set the status code
        response.setStatusCode(200);
        
        //Return the response
        return response;
    }
}