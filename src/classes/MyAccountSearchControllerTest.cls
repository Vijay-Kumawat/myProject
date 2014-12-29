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
    public class MyAccountSearchControllerTest{ 
 /*  
      Purpose      :   Test class for MyAccountSearchController
        
      Create By    :   Vijay Kumar Kumawat
  
      Created Date  :   10/08/2012
  
      Current Version  :   V1.0
  
      Revision Log  :  V1.0 - Created
            
      Coverage    :   100%
*/
        
        //Method
        private static testMethod void myUnitTest() {
        
        //Insert Account
        Account account = new Account(Name = 'TestAcc', BillingCity = 'Jaipur',
                            BillingState = 'CA', AccountNumber = '231',
                            BillingCountry = 'USA');
        insert account;
      
        //Constructor
        MyAccountSearchController controller = new MyAccountSearchController();
        
        //Test Start from here
        Test.startTest();
        
            controller.accountName = 'Test'; 
            controller.billingCity = 'Jai';
            controller.billingState = 'C';
            controller.accountNumber = '23';
            controller.billingCountry = 'US';
            
             //Calling Method
            controller.Search();
            
            //Assert for Results
            System.assertEquals(1, controller.accounts.size());
            
            controller.accountName = 'TestAcsdcsdcc'; 
            controller.billingCity = 'Jaipurvdf';
            controller.billingState = 'CAvdf';
            
            //Calling Method
            controller.Search();
            
            //Assert for Results
            System.assertEquals(0, controller.accounts.size());
            
        //Test Stop here
        Test.stopTest();
    }
}