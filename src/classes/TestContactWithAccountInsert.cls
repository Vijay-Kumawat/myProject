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
private class TestContactWithAccountInsert {
/*
  Purpose      :   Test class for ContactWithAccountInsert
        
  Create By    :   Vijay Kumar Kumawat
  
  Created Date  :   1/17/2013
  
  Current Version  :   V1.0
  
  Revision Log  :  V1.0 - Created
            
*/

    //Test Method
    public static testMethod void myUnitTest(){
    
        //Load the test Accounts from the staic resources
        List<sobject> acc = Test.loadData(Account.sObjectType , 'testAccounts');
        Account a1 = (Account)acc[0];
        
        // Verify that all 2 test accounts were created 
        System.assert(acc.size() == 2);
        
        //Load the test Contacts from the static resources
        List<sobject> con = Test.loadData(Contact.sObjectType , 'testContacts');
        Contact newContact=(Contact)con[0];
        //newContact.Account = a1;
        //update newContact;
        
        // Verify that all 2 test accounts were created 
        System.assert(con.size() == 2);
        
        ContactWithAccountInsert controller = new ContactWithAccountInsert();
        
        System.debug('@@@@@@@ Contact after update  ' + newContact);
    }
}