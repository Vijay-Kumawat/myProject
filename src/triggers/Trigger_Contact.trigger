/*
*  Description  : This trigger is responsible for populate Brand Customer Field with the Contact field.
*
*  Created By   : Vijay Kumar Kumawat
*
*  Created Date : 10/19/2012
*
*  Version      : v1.0 - Create
*/
trigger Trigger_Contact on Contact (after insert, after update, after delete) {

    //Event Type
    if(Trigger.isAfter) {
    
        //Action Type
        if(Trigger.isInsert || Trigger.isUpdate) {
        
            //Calling Method
            //ContactTriggerHelper.setBrandCustomerPhoneField(Trigger.new);
            //ContactTriggerHelper.setNoOfContacts(Trigger.new);
            ContactTriggerHelper.populateAccountType(Trigger.new , Trigger.oldMap);
            
        }
    }
    
    //Event Type
    if(Trigger.isAfter){
    
        //ActionType
        if(Trigger.isDelete){
        
            //Calling Method
            //ContactTriggerHelper.setBrandCustomerPhoneFieldAfterDeletion(Trigger.old);
        }
    }
}