/**
 *  Description     :   Scheduler class for Batch class Batch_UpdateLeadDataByAlexaResponse
 *
 *  Created Date    :   06/18/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
global class Scheduled_UpdateLeadDataByAlexaResponse implements Schedulable {

	//Execute Method to call the batch 
	public void execute(SchedulableContext sc) {
		
		//Execute Batch class and Set the Size of Batch Apex
		Database.executeBatch(new Batch_UpdateLeadDataByAlexaResponse(), 1);
		
	}
}