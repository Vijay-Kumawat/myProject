/*
* Description   : This class there to update contact records.
* 
* Revision Logs : v1.0 - Create 
*/
global class API_Factory {

    //Variable to hold the state
    public static Boolean EXECUTE_TRIGGER_CONTACT;

    //Webservice method
    webservice static void updateContact(String contactEmail) {
    
        //Set the flag value
        EXECUTE_TRIGGER_CONTACT = true;
    
        //List of contact going to be update
        List<Contact> contactGoingToBeUpdate = [SELECT ID , Delay_Stop_Contact__c , Application_Status__c FROM Contact 
                                                    WHERE Email =: contactEmail AND (Delay_Stop_Contact__c != 'Remove from List' 
                                                                            OR Delay_Stop_Contact__c != 'Contact at a Later Date')];
                     
        //Check for size
        if(contactGoingToBeUpdate.size() > 0) {
                                                
            //Update the contact fields
            contactGoingToBeUpdate[0].Delay_Stop_Contact__c = 'Contact at a Later Date';
            
            //Reset the flag value
            EXECUTE_TRIGGER_CONTACT = false;
            
            //Update contact list
            update contactGoingToBeUpdate;
        }
    }
}