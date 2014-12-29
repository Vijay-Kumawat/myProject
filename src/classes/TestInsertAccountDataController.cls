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
private class TestInsertAccountDataController {

    static testmethod void testLoadData() {
    
        // Load the test accounts from the static resource 
        List<sObject> ls = Test.loadData(Account.sObjectType, 'Accounts_Test_Data');
        
        // Verify that all 3 test accounts were created 
        System.assert(ls.size() == 2);
        
        //Fetching list of Account
        List<Account> listAccbefore = [SELECT ID, Name FROM Account];
        
        System.debug('###### Value before controller'+ listAccbefore );

    /*Result::::: ###### Value before controller(Account:{Name=Test Acc, Id=0019000000KpyxBAAR}, 
                            Account:{Name=Test Acc1, Id=0019000000KpyxCAAR})*/

        // Get first test account 
        Account a1 = (Account)ls[0];
        
        String acctName = a1.Name;
        System.debug(acctName);
        
        //Calling Constructor
        InsertAccountDataController controller = new InsertAccountDataController();
        
        //Fetching list of Account
        List<Account> listAcc = [SELECT ID, Name FROM Account];
        
        System.debug('###### Value after controller'+ listAcc );


    /*Result::::: ###### Value after controller(Account:{Name=Test Acc, Id=0019000000KpyxBAAR}, 
                            Account:{Name=Test Acc1, Id=0019000000KpyxCAAR}, 
                            Account:{Name=My Account, Id=0019000000KpyxDAAR})*/


    }
}