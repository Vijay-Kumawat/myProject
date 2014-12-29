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
 
  /*
 * Purpose         :   Test class for API_Factory
 *
 * Created Date    :   05/01/2013
 *
 * Revision Log    :   V1.0 - Created
 *
 * Coverage        :   
*/

@isTest
private class TestAPI_Factory {

    //Test method
    static testMethod void myUnitTest() {
        
        //Account Insert
        Account account = new Account();
        account.Name = 'Test';
  
        insert account;
                         
        //Contact Insert
        Contact contact = new Contact();
                 contact.LastName = 'Test1';
                 contact.FirstName = 'Test2';
                 contact.Email = 'salesforce.security@gmail.com';
                 contact.Delay_Stop_Contact__c = null;
                 contact.AccountId = account.Id;
                 
        insert contact;
                                           
        //Test start from here
        Test.startTest();
        
        //Calling Web service method
        API_Factory.updateContact(contact.Email);
        
        //List to hold contact records
        List<Contact> contactList = [SELECT Id , Email , Delay_Stop_Contact__c FROM Contact LIMIT 1];
        
        //Assert for resutls
        System.assertEquals(true , contactList.size() > 0);
        System.assertEquals(contactList[0].Delay_Stop_Contact__c , 'Contact at a Later Date');
        
        //Test stop here
        Test.stopTest();
    }
}