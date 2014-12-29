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
private class TestContactTriggerHelper {
/*
  Purpose      :   Test class for ContactTriggerHelper
        
  Create By    :   Vijay Kumar Kumawat
  
  Created Date  :   05/09/2013
  
  Current Version  :   V1.0
  
  Revision Log  :  V1.0 - Created
            
*/

    //Test Method
    static testMethod void myUnitTest(){
    
        //Insert Program Schedule
        Program_Schedule__c programSchedule = new Program_Schedule__c();
                            programSchedule.Name = 'Test Schedule';
                            //programSchedule.Cohort_and_Area__c = 'Cohort And Area';
                            
        insert programSchedule;
        
        //Insert Program Schedule
        Program_Schedule__c programSchedule2 = new Program_Schedule__c();
                            programSchedule2.Name = 'Test Schedule';
                            //programSchedule2.Cohort_and_Area__c = 'Cohort And Area2';
                            
        insert programSchedule2;
    
        //Insert Contact
        Contact contact = new Contact();
                contact.LastName = 'Test';
                contact.Interested_Program_and_Location_1__c = programSchedule.Id;
                contact.InsertUpdateFromApplication__c = true;
                //contact.Cohort_and_Area__c = 'Cohort And Area';
                
        insert contact;
        
        //Test Start from here
        Test.startTest();
        
        //List to hold Contact reocrds
        List<Contact> contactList = [SELECT ID , Interested_Program_and_Location_1__c FROM Contact];
        
        //Assert for Results
        System.assertEquals(true , contactList.size() > 0);
        System.assertEquals(programSchedule.Id , contactList[0].Interested_Program_and_Location_1__c);
        
        //Update Contact field
        //contact.Cohort_and_Area__c = 'Cohort And Area2';
        update contact;
        
        //List to hold Contact reocrds
        contactList = [SELECT ID , Interested_Program_and_Location_1__c FROM Contact];
        
        //Assert for Results
        System.assertEquals(true , contactList.size() > 0);
        System.assertEquals(programSchedule2.Id , contactList[0].Interested_Program_and_Location_1__c);
        
        //Test Stop here
        Test.stopTest();
    }
}