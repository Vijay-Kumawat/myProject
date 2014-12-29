global class Batch2 implements Database.Batchable<sObject> , Database.Stateful {
    
    //Set of Account Ids
    Set<ID> setAccIds = new Set<ID>();  
    
    //method to run batch
    public static void runJobForProperties(Set<Id> setAccountIds){
     
         Integer batchSize = 200;
         Batch2 batchToGenerateCSV = new Batch2();
         batchToGenerateCSV.setAccIds = setAccountIds;
         System.debug('##### value in set batch2' +batchToGenerateCSV.setAccIds);  
         //execute batch
         database.executebatch(batchToGenerateCSV, batchSize); 
     }
    
    //Start Method 
    global Database.QueryLocator start(Database.BatchableContext BC) { 
    
        //Query to Fetch Records
        return Database.getQueryLocator([SELECT ID, Name, AccountNumber, Phone FROM Account]);
   
    }
    
    //Execute Method
    global void  execute(Database.BatchableContext BC, List<Account> scope) {
    
        System.debug('Helooooooooooooooo');
        
    }

    //Finish Method
    global void finish(Database.BatchableContext BC){
    }
}