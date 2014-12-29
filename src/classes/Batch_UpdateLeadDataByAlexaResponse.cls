/**
 *  Description     :   Batch class for updating Leads with Rank data returned by the Alexa Web Service.
 *
 *  Created Date    :   06/18/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
global class Batch_UpdateLeadDataByAlexaResponse implements Database.Batchable<sObject>, Database.AllowsCallouts {
	
	//Start Method
	global Database.Querylocator start(Database.BatchableContext BC) {
		
		//Query for account records
    	return Database.getQueryLocator([SELECT ID, Site_URL__c From Lead WHERE Site_URL__c != null AND Site_URL__c != '' 
    										AND Alexa_Rank_Validation_Time_Stamp__c = null AND IsValid__c = false ]);
	}
	
	//Execute Method
	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		
		//List of Lead
  		List<Lead> leads = (List<Lead>)scope;
  		
  		//Wrapper Instance 
    	AlexaServiceWrapper alexaWrapper;
    	
    	//Account Instance
    	Lead lead;
  		
  		//Check list for size
  		if(leads != null) {
  			
  			//Lead Instance to hold the record
  			lead = leads[0];
  		}
  		
  		//Check for null value
  		if(String.valueOF(lead.Site_URL__c) != null || String.valueOF(lead.Site_URL__c) != '') {
		
			//Calling Alexa web service for getting website rank value both at worldwide level and at individual country level
			alexaWrapper = JSONParserBuilder.parseJSONForResponseValues(String.valueOF(lead.Site_URL__c));
  		}
  		
  		//Checking for errors
  		if(alexaWrapper.statusString == Constants.ERROR || alexaWrapper.urlString == '404') {
  				
			//Populating Account Alexa Rank fields with null value
			lead = Utility.populateLeadRankFieldsWithNull(lead.Id);
			update lead;
			
  		} else {
  			
  			//Populating Account rank fields with Alexa Rank web service response parsed values
  			lead = Utility.populateLeadAlexaFieldsWithRankValue(alexaWrapper.alexaServiceWrapper, lead.Id);
  			update lead;
  		}
	}
	
	//Finish Method
	global void finish(Database.BatchableContext BC) {
		
		/*Workaround for sending email to user whom submitted the Job*/
		// Get the ID of the AsyncApexJob representing this batch job from Database.BatchableContext.
        // Query the AsyncApexJob object to retrieve the current job's information.
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email, CreatedBy.Name  FROM AsyncApexJob 
        					WHERE Id = :BC.getJobId()];
        
        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {a.CreatedBy.Email});
        mail.setSenderDisplayName(a.CreatedBy.Name);
        mail.setSubject('Batch Process ' + a.Status);        
        mail.setPlainTextBody('Your batch job \"Batch_UpdateDataByAlexaResponse\" has finished.  It processed ' 
					            + a.totalJobItems +
					            ' batches.  Of which, ' 
					            + a.jobitemsprocessed 
					            + ' processed without any exceptions thrown and ' 
					            + a.numberOfErrors 
					            + ' batches threw unhandled exceptions.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
	}
}