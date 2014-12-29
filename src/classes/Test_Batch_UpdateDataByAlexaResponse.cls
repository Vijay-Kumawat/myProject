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
 *  Description     :   Test Class for Batch_UpdateDataByAlexaResponse
 *
 *  Created Date    :   06/17/2013
 *
 *  Revision Logs   :   v1.0 - Created  
 * 
 *  Coverage         :  v1.0 - Batch_UpdateDataByAlexaResponse     - 38%
 * 							   Scheduled_UpdateDataByAlexaResponse - 100%
 *
 **/
@isTest(seeAllData=false)
private class Test_Batch_UpdateDataByAlexaResponse {

    static testMethod void myUnitTest() {
        
        //Alexa Configuration
    	Alexa_Configuration__c alexa = new Alexa_Configuration__c(Alexa_Endpoint_URL__c = 'https://data.partnershub.com/salesforce/alexa', 
    																PH_Key__c = 'AMmceBYUtEiaCzVkoPfpTQxLv9dyRhnXFr3KuZwgTest');
		insert alexa;
		
		//Countries
		Countries__c countries1 = new Countries__c(Country_Name__c = 'INDIA', Name = 'IN');
		Countries__c countries2 = new Countries__c(Country_Name__c = 'UNITED STATES', Name = 'US');
		Countries__c countries3 = new Countries__c(Country_Name__c = 'DENMARK', Name = 'DE');
		Countries__c countries4 = new Countries__c(Country_Name__c = 'SPAIN', Name = 'ES');
		Countries__c countries5 = new Countries__c(Country_Name__c = 'FRANCE', Name = 'FR');
		Countries__c countries6 = new Countries__c(Country_Name__c = 'UNITED KINGDOM', Name = 'UK');
		
		//List of countries
		List<Countries__c> countries = new List<Countries__c>();
		
		//Populating list with value
		countries.add(countries1);
		countries.add(countries2);
		countries.add(countries3);
		countries.add(countries4);
		countries.add(countries5);
		countries.add(countries6); 
		insert countries;
		
    	//Setting Boolean flag value
    	AlexaWebServiceMock.isValidResponse = true;
    	
    	//Start Test from here
    	Test.startTest();
    	
    	//Calling Mock class for make response
    	Test.setMock(HttpCalloutMock.class , new AlexaWebServiceMock());
    	
    	//Eexecute Batch
    	database.executeBatch(new Batch_UpdateDataByAlexaResponse(), 200);
    	
    	//Start Test from here
    	Test.stopTest();
    }
}