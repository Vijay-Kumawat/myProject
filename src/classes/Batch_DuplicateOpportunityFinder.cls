/**
 * Description      :   This class is there for finding duplicates for Contact.
 *
 * Created Date     :   06-04-2013 
 * 
 * Created By       :   Vijay Kumawat
 *
 * Revisiion Logs   :   V1.0 - Created
 *
**/
//Batch Class
global class Batch_DuplicateOpportunityFinder implements Database.Batchable<sObject>, Database.stateful {
    
    //Varaible to hold records updation status counters
    private Integer successCounter = 0;
    private Integer failureCounter = 0;
    
    //Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        //Query to fetch records for Contact
        return Database.getQueryLocator([Select Id, Name, StageName, AccountId , Parent__c FROM Opportunity
                                         WHERE Parent__c = null AND Name != null AND Name != '' AND StageName != null AND StageName != '' AND AccountId != null
                                         AND AccountId != '']);
    }
    
    //Execute Method
    global void execute(Database.BatchableContext BC, List<Opportunity> scope) {
        
        //Check if record has already been parented
        Integer counter = [Select count() from Opportunity where Id =: scope[0].Id AND Parent__c = null];
       
        //Process If counter is greater than 0
        if(counter > 0) {
            
            //String to hold the fields Values for contact
            String nameString = '';
            String stageNameString = '';
            String accountId = '';
            
            //Populating String with the opportunity fields values
            if(scope[0].Name != null) {
                nameString = scope[0].Name;
            }
            if(scope[0].StageName != null) {
                stageNameString = scope[0].StageName;
            }
            if(scope[0].AccountId != null) {
            	accountId = scope[0].AccountId;
            }
            
            //Query for duplicate opportunity records from the database
            List<Opportunity> listDuplicateOpportunities = [SELECT ID, Name, StageName, AccountId, Score__c, Parent__c FROM Opportunity
                                                            WHERE Parent__c = null AND Name != null AND Name =: nameString AND StageName != null AND 
                                                            StageName =: stageNameString AND AccountId != null AND AccountId =: accountId Order By Score__c DESC];
           
            //If Duplicate records are there
            if(listDuplicateOpportunities.size() > 0) {
                
                //Variable to hold the ID of contact records having Maximum score amongs other dups 
                ID parentID = listDuplicateOpportunities[0].Id; 
                
                //Create a list to hold the records for update
                List<Opportunity> opportunityRecordsToUpdate = new List<Opportunity>();
                
                //Loop through list of duplicate opportunities
                for(Integer i =1; i<listDuplicateOpportunities.size(); i++) {
                    
                    //populating contact Parent__c field with the ID of Contact record having maximum score
                    listDuplicateOpportunities[i].Parent__c = parentID;
                    
                    //Adding record in the list for updation
                    opportunityRecordsToUpdate.add(listDuplicateOpportunities[i]);
                }
                
                //Checking list of opportunities is going to update for size
                if(opportunityRecordsToUpdate.size() > 0) {
                
                    //Update list of contacts those are in Contexts
                    Database.SaveResult[] opportunityRecordsUpdateResult = Database.update(opportunityRecordsToUpdate ,false);
                }           
            }
        }
    }
    
    //Finish Method
     global void finish(Database.BatchableContext BC) {
        
     }
}