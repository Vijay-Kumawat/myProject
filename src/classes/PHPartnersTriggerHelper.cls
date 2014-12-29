/**
 *  Description     :   Helper class for Account trigger and responsible to perform all types of logic based on request and event types. 
 *
 *  Created Date    :   06/14/2013
 * 
 *  Revision Logs   :   V1.0 - Created                    
 **/
public with sharing class PHPartnersTriggerHelper {
  
	//Method responsible for update account records data through web service callout from salesforce to alexa
  	public static void updateAccountDataFromAlexaResponse(List<Account> newAccounts) {
    
    	//Getting the first element for the list
    	Account account = newAccounts[0];
    
	    //Checking for Website field value
	    if(account.Site_URL__c != null || account.Site_URL__c != '') {
	      
      		//Make the webservice callout using future method.
      		if(!System.isFuture() && !System.isBatch()) {
                
        		//Calling future method to make the web service callouts
            	FutureCallHandler.updateAccountWithAlexaResponse(account.Site_URL__c, account.ID);
        	}
		}
  	}
}