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
 *  Description     :   Test Class for LeadAlexaRankWebServiceController
 *
 *  Created Date    :   06/18/2013
 *
 *  Revision Logs   :   v1.0 - Created  
 * 
 *  Coverage         :  v1.0 - LeadAlexaRankWebServiceController - 100%
 *							   LeadTriggerHelper                 - 100%
 * 							   
 **/
 @isTest(seeAllData=false)
private class Test_LeadAlexaRankWebServiceController {

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
		
		//Insert Lead
    	Lead lead = new Lead(LastName = 'Test1', Site_URL__c = 'www.google.com', Site_Name__c = 'test111');
    	insert lead;
    	
    	//Start Test from here
    	Test.startTest();
    	
    	//Setting Boolean flag value
    	AlexaWebServiceMock.isValidResponse = true;
    	
    	//Calling Mock class for make response
    	Test.setMock(HttpCalloutMock.class , new AlexaWebServiceMock());
    	
    	//Calling Constructor
    	ApexPages.StandardController sc = new ApexPages.StandardController(lead);
        LeadsAlexaRankWebServiceController controller = new LeadsAlexaRankWebServiceController(sc);
    	
    	//Calling Method 
    	controller.saveInformationToLead();
    	
    	//Query for records
    	List<Lead> leads = [SELECT ID, Name, Alexa_Rank_DE__c, Alexa_Rank_ES__c, Alexa_Rank_FR__c, Alexa_Rank_UK__c, Alexa_Rank_US__c, 
    								Alexa_Rank_Validation_Time_Stamp__c, Alexa_Rank_Worldwide__c, IsValid__c FROM Lead WHERE ID =: lead.ID];
    	
		//Assert for results
		System.assert(leads[0].IsValid__c);
		System.assertEquals(353, leads[0].Alexa_Rank_Worldwide__c);
		System.assertEquals(134, leads[0].Alexa_Rank_US__c);
		System.assertEquals(940, leads[0].Alexa_Rank_DE__c);
		System.assertEquals(2484, leads[0].Alexa_Rank_FR__c);
		System.assertEquals(2000, leads[0].Alexa_Rank_UK__c);
		
    	//Stop Test here
    	Test.stopTest();
    
    }
    
    static testMethod void myUnitTest1() {
    	
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
		
		//Insert account
    	Lead lead = new Lead(LastName = 'Test1', Site_URL__c = 'www.google.com', Site_Name__c = 'test112');
    	insert lead;
    	
    	//Updating Account Site URL
		lead.Site_URL__c = 'www.323232eeddefrf32.com';
		update lead;
    	
    	//Start Test from here
    	Test.startTest();
    	
    	//Setting Boolean flag value
    	AlexaWebServiceMock.isValidResponse = false;
    	
    	//Calling Mock class for make response
    	Test.setMock(HttpCalloutMock.class , new AlexaWebServiceMock());
    	
    	//Calling Constructor
    	ApexPages.StandardController sc = new ApexPages.StandardController(lead);
        LeadsAlexaRankWebServiceController controller = new LeadsAlexaRankWebServiceController(sc);
        
		//Setting wrapper values
		controller.alexaWrapperInstance.statusString = 'ERROR';
		
    	//Calling Method
    	controller.backNavigation();
    	
    	//Query for records
    	List<Lead> leads = [SELECT ID, Name, Alexa_Rank_DE__c, Alexa_Rank_ES__c, Alexa_Rank_FR__c, Alexa_Rank_UK__c, Alexa_Rank_US__c, 
    								Alexa_Rank_Validation_Time_Stamp__c, Alexa_Rank_Worldwide__c, IsValid__c FROM Lead WHERE ID =: lead.ID];
    	
		//Assert for results		 			
		System.assert(!leads[0].IsValid__c);
		System.assertEquals(null, leads[0].Alexa_Rank_Worldwide__c);
		System.assertEquals(null, leads[0].Alexa_Rank_US__c);
		System.assertEquals(null, leads[0].Alexa_Rank_DE__c);
		System.assertEquals(null, leads[0].Alexa_Rank_FR__c);
		System.assertEquals(null, leads[0].Alexa_Rank_UK__c);
		
		//Increasing coverage for constants class
		Alexa_Configuration__c alexaConfig = Constants.ALEXA_CONFIGURATION;
		Map<String, Countries__c> mapCountries = Constants.COUNTRIES_MAP;
		
		//Increasing Utility class coverage
		Utility.parseNull('abc');
		Utility.parseNull(null);
		
    	//Stop Test here
    	Test.stopTest();
    }
}