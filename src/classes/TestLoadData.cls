/*
* Description   : This is Test Class there to Check Test Load Data Functionality in Account.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 1/17/2013
*
* Version       : v1.0 - Create 
*/
@isTest
//Class
private class TestLoadData{

    //Test Method
    public static testMethod void testLoadData(){
    
        //Load the test Account from the Static Resources
        List<sObject> ls = Test.loadData(Account.sObjectType, 'testAccounts');
        // Verify that all 3 test accounts were created
        System.assert(ls.size() == 3);

        // Get first test account
        Account a1 = (Account)ls[0];
        String acctName = a1.Name;
        System.debug(acctName);
    }
}