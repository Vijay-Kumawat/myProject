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
@isTest(seeAllData=false)
private class Test_LoginController {

/** 
  * Description     :   Unit test method for Login controller of the Time sheet.
  *
  * Created By      :   Abhi Tripathi (Simplyforce Technology)
  *                
  * Created Date    :   2/24/2014    
  *
  * Revision Log    :   V1.0
  **/
    static testMethod void myUnitTest() {
        
        //List of Contact
        List<Contact> contacts = new List<Contact>();
        
        //Insert contact record
        Contact contactOfDeveloper = new Contact(LastName = 'test' , Email = 'test@testing.com', Password__c = 'sf#12345');
        Contact contactOfClient = new Contact(LastName = 'Client' , Email = 'client@testing.com', Password__c = 'sf#12345', IsClient__c = True);
        
        //Add to list
        contacts.add(contactOfDeveloper);
        contacts.add(contactOfClient);
        
        //Insert list
        insert contacts;
        
        //Test starts here
        Test.startTest();
        
        //Calling controller 
        LoginController controller = new LoginController();
        
        //Login to the site
        controller.emailId = '';
        controller.password = '';
        
        //Calling login method
        PageReference pageRef1 = controller.login();
        
        //Asserts
        System.assertEquals(true, pageRef1 == Null);
        System.assert(ApexPages.getMessages()[0].getDetail().contains( 'Email or Password cannot be Empty' ));
        
        //Again trying to login on site
        controller.emailId = 'test';
        controller.password = '12345';
        
        //Calling login method
        PageReference pageRef2 = controller.login();
        
        //Asserts
        System.assertEquals(true, pageRef2 == Null);
        System.assert(ApexPages.getMessages()[1].getDetail().contains( 'Email NOT found, Contact your Admin' ));
        
        //Again trying to login on site
        controller.emailId = 'test@testing.com';
        controller.password = '12345';
        
        //Calling login method
        PageReference pageRef3 = controller.login();
        
        //Asserts
        System.assertEquals(true, pageRef3 == Null);
        System.assert(ApexPages.getMessages()[2].getDetail().contains( 'Password is not Correct. Try Again' ));
        
        //Again trying to login on site
        controller.emailId = 'test@testing.com';
        controller.password = 'sf#12345';
        
        //Calling login method
        PageReference pageRef4 = controller.login();
        
        //Asserts
        System.assertEquals(true, pageRef4 != Null);
        
        //Insert projects
        Project__c project = new Project__c(Name = 'Test Project 1');
        insert project;
        
        //Users selects a project
        controller.selectedProject = project.Id;
        
        //Calling method
        controller.onSelectAction();
        
        //Assign a value to the list 
        controller.companies = new List<Company__c>{ new Company__c(Name = 'Test 1', Task_Name__c = 'test1', Hours__c = 3)};
        controller.companies = new List<Company__c>{ new Company__c(Name = 'Test 2', Task_Name__c = 'test2', Hours__c = 3)};
        controller.companies = new List<Company__c>{ new Company__c(Name = 'Test 3', Task_Name__c = 'test3', Hours__c = 3)};
        controller.companies = new List<Company__c>{ new Company__c(Name = 'Test 4', Task_Name__c = 'test4', Hours__c = 3)};
        controller.companies = new List<Company__c>{ new Company__c(Name = 'Test 5', Task_Name__c = 'test5', Hours__c = 3)};
        controller.companies = new List<Company__c>{ new Company__c(Name = 'Test 6', Task_Name__c = 'test6', Hours__c = 3)};
        
        //Calling method
        controller.saveRecordsToCompany();
        
        /*
            Description :   Now developer update records of his time sheet. So here we are calling all the methods again to cover the test class
                                in which all the methods will be called repetedly.
        */
        //New Instance of controller for developer
        LoginController devController = new LoginController();
        
        //Again trying to login on site
        devController.emailId = 'test@testing.com';
        devController.password = 'sf#12345';
        
        //Calling login method
        PageReference pageRef6 = devController.login();
        
        //Asserts
        System.assertEquals(true, pageRef6 != Null);
        
        //Users selects a project
        devController.selectedProject = project.Id;
        
        //Calling method
        devController.onSelectAction();
        
        //Calling method
        controller.saveRecordsToCompany();
        
        /*
            Description :   Here we are defining same but another instance of controller for the client side, Because when client get logged in
                             whole scenario changes.
        */
        //Re-initiallizing controller
        LoginController clientController = new LoginController();
        
        //Again trying to login on site
        clientController.emailId = 'client@testing.com';
        clientController.password = 'sf#12345';
        
        //Calling login method
        PageReference pageRef5 = clientController.login();
        
        //Asserts
        System.assertEquals(true, pageRef5 != Null);
        
        //Select a project
        clientController.selectedProject = project.Id;
        
        //Calling Submit method to display the records
        clientController.showFilteredRecords();
        
        //Filtering date
        clientController.carrier.Start_Date__c = Date.today() - 21;
        clientController.carrier.Final_Date__c = date.today() + 1;
        
        //Calling Submit method to display the records
        clientController.showFilteredRecords();
        
        //Select a project
        clientController.selectedProject = '';
        
        //Calling submit method
        clientController.showFilteredRecords();
        
        //Asserts
        System.assert(ApexPages.getMessages()[3].getDetail().contains( 'Please, Select a project firs' ));
      
        //Test stop test
        Test.stopTest();        
        
    }
}