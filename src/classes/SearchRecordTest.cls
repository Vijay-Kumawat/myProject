/**
  *    Description    :    Test class for SearchRecords
  *
  *    Created By     :    Subhash Garhwal
  *
  *    Created Date   :    4/20/2013
  *
  *    Revision Log   :    V_1.0 Created
**/    

//isTest annotation for the test class.
@isTest(seeAllData = false)
private class SearchRecordTest {

    //test Method
    static testmethod void autocompleteTest() {
        
        /*************** Create Test Data ******************/
        
        //List of Account
        List<Account> accounts = new List<Account>();
        
        //Preapring Data
        Account acc1 = new Account(Name = 'Demo');
        Account acc2 = new Account(Name = 'Demo1');
        Account acc3 = new Account(Name = 'Demo2');
        
        //Populating list with records
        accounts.add(acc1);
        accounts.add(acc2);
        accounts.add(acc3);
        
        //Insert List
        insert accounts;
        
        //Start test from here
        Test.startTest();
        
        //Calling class method
        String objName = SearchRecords.searchRecordDetail('Account');
        
        //Assert for results
        System.assert(objName != '');
        System.assert(true , objName.contains('Account'));
        
        //Assert in the list of account
        System.assert(accounts.size()==3);
        
        //Set Mock Callout class
        Test.setMock(HttpCalloutMock.class, new SearchRecordsMock());
        
        //Calling class method
        String objString = SearchRecords.searchRecordDetail('CustomObject');
        
        //Assert for results
        System.assert(objString != '');
        System.assert(true , objString.contains('Property'));
        System.assert(true , objString.contains('Pipeline'));
        
        //Set Mock Callout class
        Test.setMock(HttpCalloutMock.class, new SearchRecordsMockForCustomField());
        
        //Calling class method
        String fieldString = SearchRecords.searchRecordDetail('CustomField');
        
        //Assert for results
        System.assert(fieldString != '');
        System.assert(true , fieldString.contains('Status'));
        System.assert(true , fieldString.contains('Description'));
        
        //Stop test here
        Test.stopTest();
    }
}