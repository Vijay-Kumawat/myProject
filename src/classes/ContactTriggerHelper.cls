/*
* Description   : This is class there to perform Trigger Contact Functionality.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/19/2012
*
* Version       : v1.0 - Create 
*/
public class ContactTriggerHelper {

    //Method
    public static void setBrandCustomerPhoneField(List<Contact> contacts) {
    
        //Set Brand Customer Ids
        Set<Id> setBrandCustomerIds = new Set<Id>();
        
        //Set For the Contact Ids
        Set<Id> setContactIds = new Set<Id>();
        
        //Loop
        for(Contact contact : contacts){
        
            //Populate Set with Brand Customer Ids
            setBrandCustomerIds.add(contact.Brand_Customer__c);
            
            //Populate Set with Contact Ids
            setContactIds.add(contact.Id);
        }
        
        //List for Contacts
        List<Contact> listSortedContacts = new List<Contact>();
        
        //Query for Contacts records order by Last Modified Date
        listSortedContacts =  [SELECT Id, LastName, FirstName, LastModifiedDate, Brand_Customer__c, 
                               AccountId, Phone, Account.AccountNumber From Contact 
                               WHERE Brand_Customer__c In :setBrandCustomerIds
                               Order By LastModifiedDate DESC];
                                                  
        //List for Brand Customer
        List<Brand_Customer__c> listBrandCustomer = new List<Brand_Customer__c>();
        
        //Query for Brand Customer records
        listBrandCustomer = [SELECT Id, Name, Phone__c, Account_Number__c FROM Brand_Customer__c 
                             WHERE Id IN : setBrandCustomerIds];
        
        //Loop of Brand Customer
        for(Brand_Customer__c brand : listBrandCustomer){
        
            //Populate the Field Value of Brand Customer
            brand.Phone__c = listSortedContacts[0].Phone;
            
            brand.Account_Number__c = listSortedContacts[0].Account.AccountNumber;
        }
        
        //Update
        update listBrandCustomer;
     }
     
     public static void setBrandCustomerPhoneFieldAfterDeletion(List<contact> contacts){
     
         //Set Brand Customer Ids
        Set<Id> setBrandCustomerIds = new Set<Id>();
        
        //Set For the Contact Ids
        Set<Id> setContactIds = new Set<Id>();
        
        //Loop
        for(Contact contact : contacts){
        
            //Populate Set with Brand Customer Ids
            setBrandCustomerIds.add(contact.Brand_Customer__c);
            
            //Populate Set with Contact Ids
            setContactIds.add(contact.Id);
            
        }
     
         //List for Contacts
         List<Contact> listRemainingContact = new List<Contact>();
         
         //Query for Contacts records
         listRemainingContact = [SELECT Id, LastName, FirstName, LastModifiedDate, Brand_Customer__c, 
                                AccountId, Phone, Account.AccountNumber From Contact 
                                WHERE Brand_Customer__c In :setBrandCustomerIds
                                Order By LastModifiedDate DESC];
                                
         //List for Brand Customer
         List<Brand_Customer__c> listRemainingBrand = new List<Brand_Customer__c>();
         
         //Query for Brand Customer records
         listRemainingBrand = [SELECT Id, Name, Phone__c, Account_Number__c FROM Brand_Customer__c 
                               WHERE Id IN : setBrandCustomerIds];
        
        //Loop of Brand Customer
        for(Brand_Customer__c brand : listRemainingBrand){
        
            //Populate the Field Value of Brand Customer
            brand.Phone__c = listRemainingContact[0].Phone;
            
            brand.Account_Number__c = listRemainingContact[0].Account.AccountNumber;
        }
        
        //Update
        update listRemainingBrand;         
     }    
     
    //Method
    public static void setNoOfContacts(List<Contact> contacts) {
    
        Set<Id> accountIds = new Set<Id>();
        Set<Id> contactIds = new Set<Id>();
        for(Contact con : contacts) {
            contactIds.add(con.Id);
            accountIds.add(con.AccountId);
        }
        
        AggregateResult[] aggr = [Select count(Id) FROM Contact Where AccountId IN : accountIds];
        
        Integer counter = Integer.valueOf(aggr.size());
        
        System.debug('#####' + counter);
            
        for(Account acc : [SELECT ID , No_of_Contacts__c from Account]) {
            
            acc.No_of_Contacts__c = counter;
            counter ++;
            
        } 
    }
    
    //Method going to be update the Program Schedule field
    public static void updateContactLookupField(List<Contact> contacts , Map<Id ,Contact> oldMap , Boolean IsInsert) {
    
        //List to hold Contact records
        List<Contact> contactsOfInterest = new List<Contact>();
        
        //Set to hold Cohert Ids
        Set<String> cohortAreaCodes = new Set<String>();
    
        //Loop through Contact
        for(Contact c : contacts) {
        
            //Check for value
            if(c.InsertUpdateFromApplication__c == true
               && ((IsInsert == true && c.Cohort_And_Area__c != null)
               || (IsInsert == false && c.Cohort_And_Area__c != oldMap.get(c.id).Cohort_And_Area__c)))

            {
                //Populate the set with id
                cohortAreaCodes.add(c.Cohort_And_Area__c.toLowerCase());
                
                //Populate the list with Contact records
                contactsOfInterest.add(c);
            }
        }
    
        //Check for null value
        if(contactsOfInterest == null || contactsOfInterest.size() == 0) {
            
            return;
        }
     
        //Map to hold Program Schedule reocrds
        Map <String, Program_Schedule__c> psMap = new Map <String, Program_Schedule__c>();
     
        //Loop through Program Schedule
        for(Program_Schedule__c ps : [Select Id, Cohort_and_Area__c From  Program_Schedule__c
                                      Where Cohort_and_Area__c in :cohortAreaCodes])
        {
   
            //Populate the map with value    
            psMap.put(ps.cohort_and_area__c.toLowerCase(), ps);
        }
 
        //Loop through Contact
        for(Contact c : contactsOfInterest) {
        
            //Check if map Contains the value    
            if(psMap.containsKey(c.Cohort_And_Area__c.toLowerCase())) {
            
                //Populate the field
                c.Interested_Program_and_Location_1__c = psMap.get(c.Cohort_And_Area__c.toLowerCase()).id;
            }
            else {
            
             //Populate the field with null
             c.Interested_Program_and_Location_1__c = null;
            }
        }
     }
     
    //Method going to be update the Program Schedule field
    public static void updateContactLookupFieldNew(List<Contact> contacts , Map<Id ,Contact> oldMap , Boolean IsInsert) {
    
        //List to hold Contact records
        List<Contact> contactsOfInterest = new List<Contact>();
        
        //Set to hold Cohert Ids
        Set<String> cohortAreaCodes = new Set<String>();
    
        //Loop through Contact
        for(Contact c : contacts) {
        
            //Check for value
            if(c.InsertUpdateFromApplication__c == true
               && ((IsInsert == true && c.Cohort_And_Area__c != null)
                    || (IsInsert == false && c.Cohort_And_Area__c != oldMap.get(c.id).Cohort_And_Area__c))
                ) {

                //Populate the set with id
                cohortAreaCodes.add(c.Cohort_And_Area__c.toLowerCase());
                
                //Populate the list with Contact records
                contactsOfInterest.add(c);
            }
        }
    
        //Execute only if there is data to execute
        if(contactsOfInterest.size() > 0) {
            
            //Map to hold Program Schedule reocrds
            Map <String, Program_Schedule__c> psMap = new Map <String, Program_Schedule__c>();
         
            //Loop through Program Schedule
            for(Program_Schedule__c ps : [Select Id, Cohort_and_Area__c From  Program_Schedule__c
                                          Where Cohort_and_Area__c in :cohortAreaCodes])
            {
       
                //Populate the map with value    
                psMap.put(ps.Cohort_and_Area__c.toLowerCase(), ps);
            }
     
            //Loop through Contact
            for(Contact c : contactsOfInterest) {
            
                //Check if map Contains the value    
                if(psMap.containsKey(c.Cohort_And_Area__c.toLowerCase())) {
                
                    //Populate the field
                    c.Interested_Program_and_Location_1__c = psMap.get(c.Cohort_And_Area__c.toLowerCase()).id;
                }
            }
        }
    }
    
    public static void populateAccountType(List<Contact> newRecords , Map<Id,Contact> oldContacts) {
    
        List<Account> accList = new List<Account>();
        for(Contact con : newRecords) {
        
            if(con.AccountId != null && con.Type__c != null && con.Type__c == 'Reseller' && (oldContacts == null || (oldContacts.get(con.Id).Type__c
            != con.Type__c))) {
                
                
               accList.add(new Account(Id = con.AccountId , TypeValue__c = con.Type__c));
                
            }
        }
        if(accList.size() > 0)
            update acclist;
    }
}