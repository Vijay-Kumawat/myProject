@isTest

//test class
public class AccountTest{
    //Method for test class
    private static testMethod void AccUnitTest() {
    
        // this code run as  a system data       
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        //insert user
        User user1 = new User(alias = 'u1', email='u1@testorg.com',
                      emailencodingkey='UTF-8', lastname='kumawat', languagelocalekey='en_US',
                      localesidkey='en_US', profileid = p.Id, country='United States',
                      timezonesidkey='America/Los_Angeles', username='u1@testorg.com');
        insert user1;
        
        //insert user
        User user2 = new User(alias = 'u1dc', email='u1dcdc@testorg.com',
                      emailencodingkey='UTF-8', lastname='xyz', languagelocalekey='en_US',
                      localesidkey='en_US', profileid = p.Id, country='United States',
                      timezonesidkey='America/Los_Angeles', username='u1cdc@testorg.com');
        insert user2;
         
         //insert account
        Account account = new Account(Name = 'Acc');
        insert account;
        
        //Run As User 1
        System.runAs(user1){
       
            //Insert New Account
            Account account1 = new Account(Name = 'TestAcc');
            insert account1;       
            
            //Assert for Result
            System.assertEquals(true,user1.Name == account1.Logged_In_User__c);
            
            //Update Account
            update account;
            
            //Assert for Result
            System.assertEquals(true,user1.Name == account.Logged_In_User__c);            
        }
        
        //Run As User 2
        System.runAs(user2) {
        
            //Update account
            update account;
            
            //Assert for Result
            System.assertEquals(true,user2.Name == account.Logged_In_User__c);
        }
    }
}