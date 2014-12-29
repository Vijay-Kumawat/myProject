/*
* Description   : This is helper class there to perform Contact with Account Relation
* 
* Created By    : 
*
* Created Date  : 1/17/2013
*
* Version       : v1.0 - Create 
*/
// Helper Class
public class ContactWithAccountTriggerHelper {

    //Calling Method
    public static void insertContactWithAccount(List<Contact> contactList) {

        //Set for Contact Ids
        Set<Id> contactId = new Set<Id>();
        
        //Loop
        for(Contact contact : contactList){
        
            contactId.add(contact.Id);
        }
        
        //List for Contact
        List<Contact> contacts = new List<Contact>();
        
        //Query for fetching records
        contacts = [SELECT ID, FirstName , LastName , Account.Name, Account.AccountNumber FROM Contact WHERE Id IN : contactId];
    
    }
}