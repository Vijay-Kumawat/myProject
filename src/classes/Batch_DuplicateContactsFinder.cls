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
global class Batch_DuplicateContactsFinder implements Database.Batchable<sObject>, Database.stateful {
    
    //Varaible to hold records updation status counters
    private Integer successCounter = 0;
    private Integer failureCounter = 0;
    
    //Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        //Query to fetch records for Contact
        return Database.getQueryLocator([Select Id, Name, Email, Parent__c FROM Contact 
                                            WHERE Parent__c = null AND Name != null AND Name != '' AND Email != null AND Email != '']);
        
    }
    
    //Execute Method
    global void execute(Database.BatchableContext BC, List<Contact> scope) {
        
        //Check if record has already been parented
        Integer counter = [Select count() from Contact where Id =: scope[0].Id AND Parent__c = null];
       
        //Process If counter is greater than 0
        if(counter > 0) {
            
            //String to hold the fields Values for contact
            String nameString = '';
            String emailString = '';
            
            //Populating String with the contact fields values
            if(scope[0].Name != null) {
                nameString = scope[0].Name;
            }
            if(scope[0].Email != null) {
                emailString = scope[0].Email;
            }
            
            //Query for duplicate contact records from the database
            List<Contact> listDuplicateContacts = [SELECT ID, FirstName, LastName, Email, Phone, Score__c, Parent__c FROM Contact
                                                    WHERE Parent__c = null AND Name != null AND Name =: nameString AND Email != null AND 
                                                    Email =: emailString Order By Score__c DESC];
                  
            //If Duplicate records are there
            if(listDuplicateContacts.size() > 0) {
                
                //Variable to hold the ID of contact records having Maximum score amongs other dups 
                ID parentID = listDuplicateContacts[0].Id;
                
                //Create a list to hold the records for update
                List<Contact> contactRecordsToUpdate = new List<Contact>();
                
                //Loop through list of duplicate contacts
                for(Integer i =1; i<listDuplicateContacts.size(); i++) {
                    
                    //populating contact Parent__c field with the ID of Contact record having maximum score
                    listDuplicateContacts[i].Parent__c = parentID;
                    
                    //Adding record in the list for updation
                    contactRecordsToUpdate.add(listDuplicateContacts[i]);
                }
                
                //Checking list of contacts is going to update for size
                if(contactRecordsToUpdate.size() > 0) {
                
                    //Update list of contacts those are in Contexts
                    Database.SaveResult[] contactRecordsUpdateResult = Database.update(contactRecordsToUpdate ,false);
                     
                }           
            }
        }
    }
    
    //Finish Method
     global void finish(Database.BatchableContext BC) {
        
     }
}