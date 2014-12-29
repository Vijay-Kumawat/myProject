/**
 *  Description     :   Batch class for updating accounts with Rank data returned by the Alexa Web Service.
 *
 *  Created Date    :   06/14/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
global class Batch_UpdateDataByAlexaResponse implements Database.Batchable<sObject>, Database.AllowsCallouts {
	
	//Start Method
	global Database.Querylocator start(Database.BatchableContext BC) {
		
		//Query for account records
    	return Database.getQueryLocator([SELECT ID, Site_URL__c From Account WHERE Site_URL__c != null AND Site_URL__c != '' 
    										AND Alexa_Rank_Validation_Time_Stamp__c = null AND IsValid__c = false ]);
	}
	
	//Execute Method
	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		
		//List of Account
  		List<Account> accounts = (List<Account>)scope;
  		
  		//Wrapper Instance 
    	AlexaServiceWrapper alexaWrapper;
    	
    	//Account Instance
    	Account account;
  		
  		//Check list for size
  		if(accounts != null) {
  			
  			//Account Instance to hold the record
  			account = accounts[0];
  		}
  		
  		//Check for null value
  		if(String.valueOF(account.Site_URL__c) != null || String.valueOF(account.Site_URL__c) != '') {
		
			//Calling Alexa web service for getting website rank value both at worldwide level and at individual country level
			alexaWrapper = JSONParserBuilder.parseJSONForResponseValues(String.valueOF(account.Site_URL__c));
  		}
  		
  		//Checking for errors
  		if(alexaWrapper.statusString == Constants.ERROR || alexaWrapper.urlString == '404') {
  				
			//Populating Account Alexa Rank fields with null value
			account = Utility.populateAccountRankFieldsWithNull(account.Id);
			update account;
			
  		} else {
  			
  			//Populating Account rank fields with Alexa Rank web service response parsed values
  			account = Utility.populateAccountAlexaFieldsWithRankValue(alexaWrapper.alexaServiceWrapper, account.Id);
  			update account;
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