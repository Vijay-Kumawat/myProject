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
 * Description      :   Test Class for Batch_MassDuplicateContactMerge.
 *
 * Created Date     :   03-06-2014 
 * 
 * Revisiion Logs   :   V_1.0 - Created
 *
 * Code Coverage    :   100%
**/
@isTest
private class Test_Batch_MassDuplicateContactMerge {

    //Test method
    static testMethod void myUnitTest() {
    	
        //List to hold account reocrds
        List<Account> listAccounts = new List<Account>();
        
        //Create Account with iteration of count
        for(Integer i = 1 ; i < 10 ; i++) {
        	
        	//populating the list with account records
        	listAccounts.add(new Account(Name = 'TestAcc'));
        }
        
        //Insert accounts
        insert listAccounts;
        
        //List to hold contact records
        List<Contact> listContacts = new List<Contact>();
        
        //Create Contact with iteration of count
        for(integer i = 1 ; i <= 50 ; i++) {
        	
            //Populating the list of Contact records
            listContacts.add(new Contact(FirstName = 'Test' , LastName = 'Contact' , AccountId = listAccounts[0].Id , Email = 'test@test.com'));
        }
        
        //Create Contact with iteration of count
        for(integer i = 1 ; i <= 50 ; i++) {
        	
            //Populating the list of Contact records
            listContacts.add(new Contact(FirstName = 'Test1' , LastName = 'Contact1' , AccountId = listAccounts[1].Id , Email = 't@test.com'));
        }
        
        //Create Contact with iteration of count
        for(integer i = 1 ; i <= 10 ; i++) {
        	
            //Populating the list of Contact records
            listContacts.add(new Contact(FirstName = 'Test2' , LastName = 'Contact2' , AccountId = listAccounts[2].Id , Email = 'test2@test.com'));
        }
        
        //Populating the list of Contact records
        listContacts.add(new Contact(FirstName = 'Test2' , LastName = 'Contact2' , AccountId = listAccounts[2].Id , Email = 'test3@test.com'));
        listContacts.add(new Contact(FirstName = 'Test2' , LastName = 'Contact2' , AccountId = listAccounts[2].Id , Email = 'test4@test.com'));
        listContacts.add(new Contact(FirstName = 'Test2' , LastName = 'Contact2' , AccountId = listAccounts[2].Id , Email = 'test5@test.com'));
        
        //Insert contact
        insert listContacts;
        
        //List to hold task records
        List<Task> tasks = new List<Task>();
        
        //Create Task with iteration of count
        for(integer i = 1 ; i <= 20 ; i++) {
        	
            //Populating the list of task records
            tasks.add(new Task(ActivityDate = Date.today().addDays(7),Subject='Sample Task', WhoId = listContacts[0].Id,Status='In Progress'));
        }
        
        //Create Task with iteration of count
        for(integer i = 1 ; i <= 10 ; i++) {
        	
            //Populating the list of task records
            tasks.add(new Task(ActivityDate = Date.today().addDays(7),Subject='Sample Task', WhoId = listContacts[1].Id,Status='In Progress'));
        }
        
        //Insert tasks
		insert tasks;
                
        //Test start from here
        Test.startTest();
        
        //Batch Initializing
        Batch_MassDuplicateContactMerge controller = new Batch_MassDuplicateContactMerge();
                
        //Execute Batch
        Database.executeBatch(controller , 50);
        
        //Test stop here
        Test.stopTest();
        
        //Query to get contact records
        listContacts = [SELECT ID , Email FROM Contact WHERE AccountId =: listAccounts[0].Id];
        
        //Assert for results
        System.assertEquals(1 , listContacts.size());
        
        //Query to get task records
        tasks = [SELECT Id , WhoId From Task Where WhoId =: listContacts[0].Id];
        
        //Assert for results
        System.assertEquals(30 , tasks.size());
        
        //Query to get contact records
        listContacts = [SELECT ID , Email FROM Contact WHERE AccountId =: listAccounts[1].Id];
        
        //Assert for results
        System.assertEquals(1 , listContacts.size());
        
        //Query to get contact records
        listContacts = [SELECT ID , Email FROM Contact WHERE AccountId =: listAccounts[2].Id];
        
        //Assert for results
        System.assertEquals(4 , listContacts.size());
    }
}