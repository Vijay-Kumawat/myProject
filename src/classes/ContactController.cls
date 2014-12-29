/**
 *  Description     :   This calss is to serve as helper class for Contact Trigger. 
 *
 *  Revision Logs   :   V1.0 - Created
 **/
global without sharing class ContactController {
    
    //Method resposnible for updating contact by calling web service method
    //This method will work with only one record at a time
    /*public static void ContactUpdateRequest(List<Contact> newContacts, Map<Id, Contact> mapOldContacts) {
        
        //Check for the account OrderWorkplacePoster flag
        Contact contact = newContacts[0];
            
        //Check if the status of picklist fields change
        if(contact.Delay_Stop_Contact__c != null 
            && (mapOldContacts == null || contact.Delay_Stop_Contact__c !=  mapOldContacts.get(contact.Id).Delay_Stop_Contact__c) 
                || (contact.Application_Status__c != null 
                    && (mapOldContacts == null || contact.Application_Status__c != mapOldContacts.get(contact.Id).Application_Status__c))
            ) {
            
            //Make the webservice callout using future method.
            if(!System.isFuture() && !System.isBatch())
            
                //Make the webservice callout using future method. 
                FutureCallHandler.makeContactUpdateEnvelope(contact.Id);
        }
    }*/
}