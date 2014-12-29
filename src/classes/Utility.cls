/**
 *  Description     :   Apex class to hold the generic methods.
 *
 *  Created Date    :   06/06/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
global class Utility {
	
	//Web service method to call the Alexa Rank Service batches from list view button
	WebService static Boolean callAlexaRankServiceBatch() {
		
		//Boolean variable for deciding batch to execute or not
		Boolean executeBatch;
		
		//Query for Asyncronous Batch Job currently in process
		List<AsyncApexJob> a = [SELECT Id, Status, ApexClassID, ApexClass.Name FROM AsyncApexJob
									WHERE ApexClass.Name = 'Batch_UpdateDataByAlexaResponse' AND (Status = 'Queued' OR Status = 'Processing' OR Status = 'Preparing')];
		
		//Check for list size
		if(a.size() > 0) {
			
			//Set boolean variable
			executeBatch = false;
			
		} else {
			
			//Set Boolean variable
			executeBatch = true;
		
			//Calling Batch with size of 1
			database.executeBatch(new Batch_UpdateDataByAlexaResponse(), 1); 
		}
		
		//Return Boolean
		return executeBatch;
	}
	
	//Web service method to call the Alexa Rank Service batches from list view button (Lead)
	WebService static Boolean callAlexaRankServiceBatchForLeads() {
		
		//Boolean variable for deciding batch to execute or not
		Boolean executeBatch;
		
		//Query for Asyncronous Batch Job currently in process
		List<AsyncApexJob> a = [SELECT Id, Status, ApexClassID, ApexClass.Name FROM AsyncApexJob
									WHERE ApexClass.Name = 'Batch_UpdateLeadDataByAlexaResponse' AND (Status = 'Queued' OR Status = 'Processing' OR Status = 'Preparing')];
		
		//Check for list size
		if(a.size() > 0) {
			
			//Set boolean variable
			executeBatch = false;
			
		} else {
			
			//Set Boolean variable
			executeBatch = true;
		
			//Calling Batch with size of 1
			database.executeBatch(new Batch_UpdateLeadDataByAlexaResponse(), 1); 
		}
		
		//Return Boolean
		return executeBatch;
	}
	
	//Method to return the date time String for Local User time
    public static String sQLdateTimeString() {
    	
    	//Getting current GMT Time zone value
    	DateTime dateTimeValue = System.now();
    	
    	//Month String
    	String monthValue;
    	if(Integer.valueOf(String.valueof(dateTimeValue.month()).length()) == 2) {
    		monthValue = String.valueof(dateTimeValue.month());
    	} else {
    		monthValue = '0' + String.valueof(dateTimeValue.month());
    	}
    	
    	//Day string
    	String dayValue;
    	if(Integer.valueOf(String.valueof(dateTimeValue.day()).length()) == 2) {
    		dayValue = String.valueof(dateTimeValue.day());
    	} else {
    		dayValue = '0' + String.valueof(dateTimeValue.day());
    	}
    	
		//Hour String
		String hourValue;
    	if(Integer.valueOf(String.valueof(dateTimeValue.hour()).length()) == 2) {
    		hourValue = String.valueof(dateTimeValue.hour());
    	} else {
    		hourValue = '0' + String.valueof(dateTimeValue.hour());
    	}				 	
		
		//Minute String
		String minuteValue;
    	if(Integer.valueOf(String.valueof(dateTimeValue.minute()).length()) == 2) {
    		minuteValue = String.valueof(dateTimeValue.minute());
    	} else {
    		minuteValue = '0' + String.valueof(dateTimeValue.minute());
    	}	
								 	
		//Second String
		String secondValue;
    	if(Integer.valueOf(String.valueof(dateTimeValue.second()).length()) == 2) {
    		secondValue = String.valueof(dateTimeValue.second());
    	} else {
    		secondValue = '0' + String.valueof(dateTimeValue.second());
    	}	
							 	
    	//Buildig Overall desired date time string
		String currentDateTime =  String.valueof(dateTimeValue.year()) + '-' +  monthValue + '-' + dayValue + ' ' + hourValue + ':' + minuteValue + ':' + secondValue;
									
		System.debug('@@@@@@ value in date ' + currentDateTime);
		
		//Return Date Time String
		return currentDateTime;
    }	
    
    //Check for Null and if yes, then return blank
    public static String parseNull(String value) {
    	
    	//Return blank if value is null
    	if(value == null)
    		return '';
		
		//return original value
		return value;
    }
    
    //Method to retrieve rank value for individual country based on contry code
    public static Account populateAccountAlexaFieldsWithRankValue(List<AlexaServiceResponseWrapper> alexaResponseWrapperList, ID accountID) {
    	
    	//Account instance
    	Account account = new Account(ID = accountID);
    	
    	//loop through wrapper list for populating Account fields with values
		for(AlexaServiceResponseWrapper alexaWrap : alexaResponseWrapperList) {
				
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'US') {
				
				//Popualte field with value
				account.Alexa_Rank_US__c = alexaWrap.countryWiseRank;
				
			}
				
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'UK') {
				
				//Popualte field with value
				account.Alexa_Rank_UK__c = alexaWrap.countryWiseRank;
				
			}
			
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'FR') {
				
				//Popualte field with value
				account.Alexa_Rank_FR__c = alexaWrap.countryWiseRank;
				
			}
			
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'ES') {
				
				//Popualte field with value
				account.Alexa_Rank_ES__c = alexaWrap.countryWiseRank;
				
			}
			
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'DE') {
				
				//Popualte field with value
				account.Alexa_Rank_DE__c = alexaWrap.countryWiseRank;
				
			}
			
			//Populating some other fields
			account.Alexa_Rank_Validation_Time_Stamp__c =  datetime.newinstance(System.now().date(),System.now().time());
			account.IsValid__c = true;
			 
    	}
    	
    	//Return Account
		return account;
    }
    
    //Method to populate account rank fields with null values
    public static Account populateAccountRankFieldsWithNull(ID accountID) {
    	
    	//Account instance
    	Account account = new Account(ID = accountID);
    	account.Alexa_Rank_Worldwide__c = null;
        account.Alexa_Rank_US__c = null;
        account.Alexa_Rank_UK__c = null;
        account.Alexa_Rank_FR__c = null;
        account.Alexa_Rank_ES__c = null;
        account.Alexa_Rank_DE__c = null;
        account.Alexa_Rank_Validation_Time_Stamp__c =  datetime.newinstance(System.now().date(),System.now().time());
        account.IsValid__c = false;
    	    	
    	//Return Account
		return account;
    }
    
    //Method to retrieve rank value for individual country based on contry code
    public static Lead populateLeadAlexaFieldsWithRankValue(List<AlexaServiceResponseWrapper> alexaResponseWrapperList, ID leadID) {
    	
    	//Lead instance
    	Lead lead = new Lead(ID = leadID);
    	
    	//loop through wrapper list for populating Lead fields with values
		for(AlexaServiceResponseWrapper alexaWrap : alexaResponseWrapperList) {
				
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'US') {
				
				//Popualte field with value
				lead.Alexa_Rank_US__c = alexaWrap.countryWiseRank;
				
			}
				
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'UK') {
				
				//Popualte field with value
				lead.Alexa_Rank_UK__c = alexaWrap.countryWiseRank;
				
			}
			
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'FR') {
				
				//Popualte field with value
				lead.Alexa_Rank_FR__c = alexaWrap.countryWiseRank;
				
			}
			
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'ES') {
				
				//Popualte field with value
				lead.Alexa_Rank_ES__c = alexaWrap.countryWiseRank;
				
			}
			
			//Check for value
			if(alexaWrap.countryCode.toUpperCase() == 'DE') {
				
				//Popualte field with value
				lead.Alexa_Rank_DE__c = alexaWrap.countryWiseRank;
				
			}
			
			//Populating some other fields
			lead.Alexa_Rank_Validation_Time_Stamp__c =  datetime.newinstance(System.now().date(),System.now().time());
			lead.IsValid__c = true;
			 
    	}
    	
    	//Return Lead
		return lead;
    }
    
    //Method to populate account rank fields with null values
    public static Lead populateLeadRankFieldsWithNull(ID leadID) {
    	
    	//Account instance
    	Lead lead = new Lead(ID = leadID);
    	lead.Alexa_Rank_Worldwide__c = null;
        lead.Alexa_Rank_US__c = null;
        lead.Alexa_Rank_UK__c = null;
        lead.Alexa_Rank_FR__c = null;
        lead.Alexa_Rank_ES__c = null;
        lead.Alexa_Rank_DE__c = null;
        lead.Alexa_Rank_Validation_Time_Stamp__c =  datetime.newinstance(System.now().date(),System.now().time());
        lead.IsValid__c = false;
    	    	
    	//Return Account
		return lead;
    }
}