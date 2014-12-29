global class Batch1 implements Database.Batchable<sObject> {
    
    //Set of Account Ids
    Set<ID> setAccountIds = new Set<ID>();  
    List<Contact> listAccount = new List<Contact>();
    
    //Start Method 
    global Database.QueryLocator start(Database.BatchableContext BC) { 
    
        //Query to Fetch Records
        return Database.getQueryLocator([SELECT ID, AccountId , Name FROM Contact]);
   
    }
    
    //Execute Method
    global void  execute(Database.BatchableContext BC, List<Contact> scope) {
        
        
        listAccount = scope;
        listAccount[0].AccountId = '0039000000iyWUz';
        
        Database.update(listAccount,false);
    }

    //Finish Method
    global void finish(Database.BatchableContext BC){
    
        Batch2.runJobForProperties(setAccountIds);
    }
}