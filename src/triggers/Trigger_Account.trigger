/**
 *  Description     :   Trigger responsible for performing actions and validations on Account object events.
 *
 *  Created Date    :   06/14/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
trigger Trigger_Account on Account (after insert, after update, before insert, before update) {
	
	//Check for request type
  	if(Trigger.isAfter) {
    
    	//Check for event type
    	if(Trigger.isInsert || Trigger.isUpdate) {
      	
      		//Call helper class method
      		AccountTriggerHelper.createAccountTeamMember(Trigger.new , Trigger.oldMap); 
    	}
  	}
}