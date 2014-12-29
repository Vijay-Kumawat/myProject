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
 
@isTest

//Test Class
private class ContactTriggerHelperTest {
/*
  Purpose      :   Test class for ContactTriggerHelper 
        
  Create By    :   Vijay Kumar Kumawat
  
  Created Date  :   10/19/2012
  
  Current Version  :   V1.0
  
  Revision Log  :  V1.0 - Created
            
  Coverage    :   
*/

    //Test Method for Insert Case
    private static testMethod void myUnitTest(){
        
    //Insert Account
    Account account = new Account(Name = 'Acc', BillingCity = 'Jaipur', BillingState = 'Rajasthan',
                                  AccountNumber = '123456', BillingCountry = 'India');
         insert account;
   
    //Brand Customer
    Brand_Customer__c brandCustomer = new Brand_Customer__c(Name = 'Mr.Ezio');
    insert brandCustomer;
    
    //Contact
    Contact contact = new Contact(LastName = 'Salman', FirstName = 'Khan', Phone = '1111122222',
                                  AccountId = account.Id, Brand_Customer__c = brandCustomer.Id);
        
    //Test start from here
    Test.startTest();
    
        insert contact;
        
        //List for Contact
        List<Contact> contactList = [SELECT Id, Name, Phone, Account.AccountNumber, AccountId FROM Contact];
    
        //List for Brand Customer
        List<Brand_Customer__c> brandList = [SELECT ID, Name, Account_Number__c, Phone__c FROM Brand_Customer__c];

        //Assert for Results
        System.assertEquals(1, brandList.size());
        System.assertEquals('1111122222' , brandList[0].Phone__c);
        System.assertEquals(1, contactList.size());
        System.assertEquals(true, brandList[0].Phone__c == contactList[0].Phone);
        System.assertEquals('123456', brandList[0].Account_Number__c);
        System.assertEquals(true, brandList[0].Account_Number__c == contactList[0].Account.AccountNumber);
        
    //Stop Test Here
    Test.stopTest();
    }
    
    //Test Method for Delete Case
    private static testMethod void myUnitTest1(){
        
    //Insert Account
    Account account = new Account(Name = 'Acc', BillingCity = 'Jaipur', BillingState = 'Rajasthan',
                                  AccountNumber = '11223344', BillingCountry = 'India');
         insert account;
   
    //Brand Customer
    Brand_Customer__c brandCustomer = new Brand_Customer__c(Name = 'Mr.Ezio');
    insert brandCustomer;
    
    //Contact
    Contact contact1 = new Contact(LastName = 'Salman', FirstName = 'Khan', Phone = '1111122222',
                                  AccountId = account.Id, Brand_Customer__c = brandCustomer.Id);
         insert contact1;                         
                                  
    Contact contact2 = new Contact(LastName = 'Aamir', FirstName = 'Khan', Phone = '3333344444',
                                  AccountId = account.Id, Brand_Customer__c = brandCustomer.Id);
         insert contact2;  
                                  
    Contact contact3 = new Contact(LastName = 'Shahrukh', FirstName = 'Khan', Phone = '5555566666',
                                  AccountId = account.Id, Brand_Customer__c = brandCustomer.Id);
         insert contact3;               
                                 
    Contact contact4 = new Contact(LastName = 'Saif', FirstName = 'Ali', Phone = '7777788888',
                                  AccountId = account.Id, Brand_Customer__c = brandCustomer.Id);
         insert contact4;                         
        
    //Test start from here
    Test.startTest();
    
        delete contact1;
    
        //List for Contact
        List<Contact> contactList = [SELECT Id, Name, Phone, Account.AccountNumber, AccountId FROM Contact];
    
        //List for Brand Customer
        List<Brand_Customer__c> brandList = [SELECT ID, Name,Account_Number__c, Phone__c FROM Brand_Customer__c];

        //Assert for Results
        System.assertEquals(1, brandList.size());
        System.assertEquals('3333344444' , brandList[0].Phone__c);
        System.assertEquals(3, contactList.size());
        System.assertEquals(true, brandList[0].Phone__c == contactList[0].Phone);
        System.assertEquals('11223344', brandList[0].Account_Number__c);
        System.assertEquals(true, brandList[0].Account_Number__c == contactList[0].Account.AccountNumber);
    
    //Stop Test Here
    Test.stopTest();
    }
}