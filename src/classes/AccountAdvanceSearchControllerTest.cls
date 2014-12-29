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
private class AccountAdvanceSearchControllerTest {
/*
  Purpose      :   Test class for AccountAdvanceSearchController
        
  Create By    :   Vijay Kumar Kumawat
  
  Created Date  :   10/08/2012
  
  Current Version  :   V1.0
  
  Revision Log  :  V1.0 - Created
            
  Coverage    :   100%
*/

    //Test Method
    private static testMethod void myUnitTest(){
        
    //Insert Account
    Account account = new Account(Name = 'Acc', BillingCity = 'Jaipur', BillingState = 'Rajasthan',
                                  AccountNumber = '123456', BillingCountry = 'India');
        
    insert account;
        
    //Test start from here
    Test.startTest();
        
        //Calling Constructor
        ApexPages.StandardController sc = new ApexPages.StandardController(account); 
        AccountAdvanceSearchController controller = new AccountAdvanceSearchController(sc);
        
        //populate the account field
        controller.account.Name = 'Ac';
        controller.account.BillingCity = 'Jaip';
        controller.account.BillingState = 'Rajastha';
        controller.account.AccountNumber = '12345';
        controller.account.BillingCountry = 'Indi';
        
        //Calling Method
        controller.search();
        
        //Assert for Result
        System.assertEquals(1, controller.accounts.size());
        
        //populate the account field
        controller.account.Name = 'Ac';
        controller.account.BillingCity = 'Jaip';
        controller.account.BillingState = 'Rajastha';

        //Calling Method
        controller.search();
        
        //Assert for Result
        System.assertEquals(1, controller.accounts.size());
        
        
        //populate the account field
        controller.account.Name = 'Ac';
        controller.account.BillingCity = 'Jaip';
        controller.account.BillingState = 'Rajastcdva';

        //Calling Method
        controller.search();
        
        //Assert for Result
        System.assertEquals(0, controller.accounts.size());       
       
        //populate the account field
        controller.account.Name = 'Acmnfnsk';
        controller.account.BillingCity = 'Jaipoisfuoifuo';
        controller.account.BillingState = 'Rafklsfjksjkls;';
        controller.account.AccountNumber = '177755';
        controller.account.BillingCountry = 'Indilfkjkljjk;l';
        
        //Calling Method
        controller.search();
        
        //Assert for Result
        System.assertEquals(0, controller.accounts.size());
    
    //Stop Test Here    
    Test.stopTest();
      
    }
}