/**
 *  Description     :   This is controller class for MarsUpdateMargin Page.
 * 
 *  Created By      :   
 * 
 *  Created Date    :   07/17/2013
 * 
 *  Revision Logs   :   V_1.0 - Created 
 *
 **/
public class MarsUpdateMarginController {

    //QuoteLineItem
    public Contact contact {get; set;}
    
    //Boolean variable
    public Boolean isSuccessfullyUpdate {get; set;}
    
    //Set to hold ids
    Set<String> setContactIds = new Set<String>();
    
    //List to hold contact records
    public List<Contact> contactRecords = new List<Contact>();

    //StandardController
    public MarsUpdateMarginController() {
    
        //Set default
        isSuccessfullyUpdate = false;
        contact = new Contact();
    }
    
    //Method for Update selected quote line items
    public void updateSelectedItems() {
        
        //Create a savepoint to rollbak the transaction in case of exception
        SavePoint sp = database.setSavePoint();

        try {
        
            //Get recordIds from URL
            String selectedStringIds = ApexPages.currentPage().getParameters().get('selectedIds');
           
            //Check for null String
            if(selectedStringIds != null && selectedStringIds != '') {
                       
                //Loop through String
                for(String str : selectedStringIds.split(',')) {
                    
                    //Populate the set with ids
                    setContactIds.add(str);
                }
                
                //query to fetch record from quote line item
                contactRecords = [SELECT ID , Margin__c From Contact WHERE Id IN : setContactIds];
            
                //loop through quote line items 
                for(Contact con : contactRecords ) {
                
                    //Update Margin field
                    con.Margin__c = contact.Margin__c;
                }
                
                //Update list
                update contactRecords;
                
                //Set value
                isSuccessfullyUpdate = true;
            } 
            else {
                //query to fetch record from quote line item
                contactRecords= [SELECT ID , Margin__c From Contact];
            
                //loop through quote line items 
                for(Contact con : contactRecords) {
                
                    //Update Margin field
                    con.Margin__c = contact.Margin__c;
                }
                
                //Update list
                update contactRecords;
                
                //Set value
                isSuccessfullyUpdate = true;
            }
            
        } catch(Exception e) {
            
            //Rollback the transaction
            database.rollback(sp);

            //Add error on page
            ApexPages.addMessages(e);
        }
    }
}