/*
*  Description  : This trigger is responsible for insert contact with account field.
*
*  Created By   : 
*
*  Created Date : 1/17/2013
*
*  Version      : v1.0 - Create
*/
trigger ContactWithAccountRelation on Contact (before insert) {

    //Event Type
    if(Trigger.isBefore){
    
        //Action Type
        if(Trigger.isInsert){
        
            //Calling Method
            ContactWithAccountTriggerHelper.insertContactWithAccount(Trigger.New);
        }
    }
}