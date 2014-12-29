/**
 *  Description     :   Trigger responsible for all pre and post processing of lead record on some event.
 *
 *  Created Date    :   06/18/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
trigger Trigger_Lead on Lead (after insert, after update, before insert, before update) {
	
	//Check for request type
  	if(Trigger.isAfter) {
    
    	//Check for event type
    	if(Trigger.isInsert || Trigger.isUpdate) {
      
      		//Calling Helper class method
      		LeadTriggerHelper.updateLeadDataFromAlexaResponse(Trigger.new);
    	}
  	}
}