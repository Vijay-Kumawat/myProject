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
 * Purpose         :   Test class for AccountWithContactFormController
 *
 * Created Date    :   03/12/2014
 *
 * Revision Log    :   V_1.0 - Created
 *
 * Coverage        :   96%
*/         

@isTest 
private class Test_AccountWithContactFormController {

    //Test method
    static testMethod void myUnitTest() {

        /******************Create test data***********************/
        
        //Get Profile
        List<Profile> profiles = [SELECT Id, Name from Profile WHERE Name = 'Restricted Profile' LIMIT 1];
        
        //Create Test User
        User testUser = new User(Username = Math.random()+'@abc.com', LastName = 'Test User1', FirstName = 'Test1', Email = Math.random()+'@test.com',
                            Alias = 'Test1', EmailEncodingKey='UTF-8', languagelocalekey = 'en_US', ProfileId = profiles[0].Id, 
                            timezonesidkey = 'America/Los_Angeles', localesidkey = 'en_US', EmployeeNumber = '12121212', IsActive = true);
        
        //insert user
        insert testUser;
        
        //Account
        Account account = new Account();
        		account.Name = 'TestAcc';
		insert account;
		
		//Contact
		Contact contact = new Contact();
				contact.LastName = 'Contact';
				contact.Email = 'test@test.com';
				contact.AccountId = account.Id;
				contact.OwnerId = testUser.Id;
		insert contact;
		
        //Test start from here
        Test.startTest();
        
        //Constructor Calling
        AccountWithContactFormController controller = new AccountWithContactFormController();
        
        //Populate the properties default
        controller.account.Name = 'IPhone';
        controller.contact.LastName = 'Testing';
        controller.contact.Email = 'my@t.com';
        controller.contact.OwnerId = testUser.Id;

        //Method calling
        controller.validateInsert();
        
        //Query to get records
        List<Account> accounts = [Select Id, Name, (Select Id, LastName, Email From Contacts) From Account Where Name = 'IPhone'];

        //Assert for results
        System.assert(accounts.size() > 0);
        System.assert(controller.mapAccounts.size() == 0);
        System.assert(controller.mapContacts.size()== 0);
        
        //Populate the properties default
        controller.account.Name = 'TestAcc';
        controller.contact.LastName = 'Contact';
        controller.contact.Email = 'test@test.com';
        controller.contact.OwnerId = testUser.Id;
        
        //Method calling
        controller.validateInsert();
        
        //Assert for results
        System.assert(controller.mapAccounts.size() > 0);
        System.assert(controller.mapContacts.size() > 0);
        
        //Set controller properties
        controller.selectedAccountId = account.Id;
        controller.selectedContactId = contact.Id;
        controller.accountActionType = 'oAll';
        controller.contactActionType = 'oAll';

        //Method calling
        controller.manualSubmit();
        
        //Populate the properties default
        controller.account.Name = 'TestAcc';
        controller.contact.LastName = 'Contact';
        controller.contact.Email = 'test@test.com';
        controller.contact.OwnerId = testUser.Id;
        
        //Method calling
        controller.validateInsert();
        
        //Assert for results
        System.assert(controller.mapAccounts.size() > 0);
        System.assert(controller.mapContacts.size() > 0);
        
        //Set controller properties
        controller.selectedAccountId = account.Id;
        controller.selectedContactId = contact.Id;
        controller.accountActionType = 'oBlank';
        controller.contactActionType = 'oBlank';
        
        controller.manualSubmit();

        //Set selected account
        controller.selectedAccountId = account.Id;
        
        //Method calling
        controller.getSelectedMergeAccount();
        
        //Assert for results
        System.assert(controller.mergingAccount.Id != null);
        System.assertEquals('TestAcc' , controller.mergingAccount.Name);
        
        //Set selected contact
        controller.selectedContactId = contact.Id;
         
        //Method calling      
        controller.getSelectedMergeContact();      
        
        //Assert for results
        System.assert(controller.mergingContact.Id != null);
        System.assertEquals('Contact' , controller.mergingContact.LastName);
        
        //Query to get records
        accounts = [Select Id, Name,(Select Id, LastName, Email From Contacts) From Account];
        
        //Assert for results
        System.assertEquals(2 , accounts.size());
        
        //Test Stop here
        Test.stopTest();
    }
}