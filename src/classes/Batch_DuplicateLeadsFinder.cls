/**
 * Description      :   This class is there for finding duplicates for Leads.
 *
 * Created Date     :   06-04-2013 
 *
 * Revisiion Logs   :   V1.0 - Created
 *
**/
//Batch Class
global class Batch_DuplicateLeadsFinder implements Database.Batchable<sObject> {
    
    //Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        //Query to fetch records for Contact
        return Database.getQueryLocator([Select Id, Name, Email, Parent__c FROM Lead 
                                            WHERE Parent__c = null AND Name != null AND Name != '' AND Email != null AND Email != '']);
        
    }
    
    //Execute Method
    global void execute(Database.BatchableContext BC, List<Lead> scope) {
        
        //Check if record has already been parented
        Integer counter = [Select count() from Lead where Id =: scope[0].Id AND Parent__c = null];
       
        //Process If counter is greater than 0
        if(counter > 0) {
            
            //String to hold the fields Values for Lead
            String nameString = '';
            String emailString = '';
            
            //Populating String with the Lead fields values
            if(scope[0].Name != null) {
                nameString = scope[0].Name;
            }
            if(scope[0].Email != null) {
                emailString = scope[0].Email;
            }
            
            //Query for duplicate Lead records from the database
            List<Lead> listDuplicateLeads = [SELECT ID, FirstName, LastName, Email, Phone, Score__c, Parent__c FROM Lead
                                                    WHERE Parent__c = null AND Name != null AND Name =: nameString AND Email != null AND 
                                                    Email =: emailString Order By Score__c DESC];
                  
            //If Duplicate records are there
            if(listDuplicateLeads.size() > 0) {
                
                //Variable to hold the ID of Lead records having Maximum score amongs other dups 
                ID parentID = listDuplicateLeads[0].Id;
                
                //Create a list to hold the records for update
                List<Lead> leadRecordsToUpdate = new List<Lead>();
                
                //Loop through list of duplicate leads
                for(Integer i =1; i<listDuplicateLeads.size(); i++) {
                    
                    //populating contact Parent__c field with the ID of Lead record having maximum score
                    listDuplicateLeads[i].Parent__c = parentID;
                    
                    //Adding record in the list for updation
                    leadRecordsToUpdate.add(listDuplicateLeads[i]);
                }
                
                //Checking list of Leads is going to update for size
                if(leadRecordsToUpdate.size() > 0) {
                
                    //Update list of contacts
                    Database.SaveResult[] results = Database.update(leadRecordsToUpdate ,false);
                }           
            }
        }
    }
    
    //Finish Method
     global void finish(Database.BatchableContext BC) {
        
        
     }
}