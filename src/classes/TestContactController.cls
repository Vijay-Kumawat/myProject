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
private class TestContactController {
/*
 * Purpose         :   Test class for ContactController
 *
 * Created Date    :   05/01/2013
 *
 * Revision Log    :   V1.0 - Created
 *
 * Coverage        :   100%
*/
    //Test Method
    private static testMethod void myUnitTest() {
    
        /*Creating Test Data for Testing*/
        
        //Insert Custom Setting(Configuration Manager)
        Configuration_Manager__c config = new Configuration_Manager__c();
                                 config.Bronto_API_Key__c = '669E8C79-9BCA-44E1-8ED7-ACE9E58077DB';
                                 config.Bronto_Endpoint_URL__c = 'http://api.bronto.com/v4';
                                 config.SOAP_NS__c = 'http://schemas.xmlsoap.org/soap/envelope/';
                                 config.Bronto_NS__c = 'http://api.bronto.com/v4';
                                 config.API_Factory_NS__c = 'http://soap.sforce.com/schemas/class/API_Factory';
                                  
        insert config;
        
        //Account Insert
        Account account = new Account();
                account.Name = 'Test';
  
        insert account;
                         
        //Contact Insert
        Contact contact = new Contact();
                 contact.LastName = 'Test1';
                 contact.FirstName = 'Test2';
                 contact.Email = 'salesforce@security.com';
                 contact.Delay_Stop_Contact__c = 'Remove From List';
                 contact.AccountId = account.Id;
                                           
        //Test start from here
        Test.startTest();
        
        //Set Mock Callout class
        Test.setMock(HttpCalloutMock.class, new HttpRequestHandlerMockClass());
        
        //Insert Contact
        insert contact;
        
        //Populate Contact field
        contact.Application_Status__c = 'Application ARC';
        
        //Set Mock Callout class
        Test.setMock(HttpCalloutMock.class, new HttpRequestHandlerMockClass());
              
        //Update contact
        update contact;
        
        //Calling method
        BrontoSOAPEnvelopeBuilder.parseNull(null); 
        BrontoSOAPEnvelopeBuilder.parseNull('abc');
        
        //String to hold values
        String sessionId = '12343-434343-45656757';
        String contactBrontoId = '0bb903e8000000000000000000000892f5f3';
        
        //List to hold ids
        List<String> listHavingListIds = new List<String>{'0bb903ec000000000000000000000004f584', '0bb903ec000000000000000000000004dce5'};
        
        //Calling Envelope Builder Method
        BrontoSOAPEnvelopeBuilder.createContactUpdateEnvelope(sessionId, contact.Id);
        BrontoSOAPEnvelopeBuilder.createReadContactsEnvelope(sessionId, contactBrontoID);
        
        //Loop through list ids
        for(Integer j=0; j<listHavingListIds.size(); j++) {
        
            //Calling Remove from envelope method
            BrontoSOAPEnvelopeBuilder.createRemoveFromListEnvelope(sessionId, listHavingListIds, j, contactBrontoId, contact.ID);
        }
        
        //Test stop here
        Test.stopTest();
    }
    
    //Test Method to cover null part and exception part
    private static testMethod void myUnitTest1() {
    
        /*Creating Test Data for Testing*/
        
        //Account Insert
        Account account = new Account();
                account.Name = 'Test';
  
        insert account;
                         
        //Contact Insert
        Contact contact = new Contact();
                 contact.LastName = 'Test1';
                 contact.FirstName = 'Test2';
                 contact.Email = 'salesforce@security.com';
                 contact.Application_Status__c = null;
                 contact.Delay_Stop_Contact__c = null;
                 contact.AccountId = account.Id;
                                           
        //Test start from here
        Test.startTest();
        
        insert contact;
        
        //String tho hold session id
        String sessionId = '12343-434343-45656757';
        
        //Set Mock Callout class
        Test.setMock(HttpCalloutMock.class, new HttpRequestHandlerMockClass());
              
        //Calling Envelope Builder Method
        BrontoSOAPEnvelopeBuilder.createContactUpdateEnvelope(sessionId, contact.ID);
       
        //Test stop here
        Test.stopTest();
    }
}