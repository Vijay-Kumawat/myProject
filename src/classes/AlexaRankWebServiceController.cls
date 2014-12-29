/**
 *  Description     :   Apex class having logic for Alexa web service callout.
 *
 *  Created Date    :   06/12/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
public with sharing class AlexaRankWebServiceController {
	
    //String to hold Account Site URL field value
    String accountSiteURL;
    
    //Wrapper Instance
    public AlexaServiceWrapper alexaWrapperInstance {get; set;}

    //Boolean variable is going to be helpful in rerendering
    public Boolean isRequestValid {get; set;}
    
    //Variable to hold the Pagereference
    PageReference pageRef;
    
    //Account Instance
    Account phPartner;
    
    //Calling constructor
    public AlexaRankWebServiceController(ApexPages.StandardController controller) {
    	
    	//Getting Lead record
    	phPartner = (Account)controller.getRecord();
    	
    	//Setting value of flag
    	isRequestValid = true;
    	
    	//Validating account presence
    	if(phPartner != null) {
    	
	    	//Getting Account Site URL value corresponding to the Id value
	    	accountSiteURL = [SELECT ID, Site_URL__c FROM Account WHERE ID =: phPartner.ID LIMIT 1].Site_URL__c;
    	}
    	
    	//Getting Wrapper populated with the values returned by the web service 
  		alexaWrapperInstance = JSONParserBuilder.parseJSONForResponseValues(accountSiteURL);
  		System.debug('######## value in alexaWrapperInstance ' + alexaWrapperInstance);
  		
  		//Checking for errors
  		if(alexaWrapperInstance.statusString == Constants.ERROR || alexaWrapperInstance.urlString == '404' || String.valueOf(alexaWrapperInstance.worldWideRank) == null) {
  				
  			//Set flag value
            isRequestValid = false;
            	
            //Adding Message on Page
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, System.label.ERROR_IN_CONTACTING_AWIS));
  		}
    }
    
  	//Method for Back Button
    public Pagereference backNavigation() {
    	
    	//populating Ph-Partner with values
		phPartner = Utility.populateAccountRankFieldsWithNull(phPartner.ID);
		
        //Update Account
    	update phPartner;
    		
    	//Return Back to Account Detail Page
 		pageRef = new PageReference('/' + phPartner.ID); 	
 		return pageRef;
    }
    
    //Method to populate Alexa fields on account record with values returned by the web service
    public Pagereference saveInformationToAccount() {
    	
    	//Setting value of flag
    	isRequestValid = true;
			 
		//Getting Account populated with individual Rank field values
		phPartner = Utility.populateAccountAlexaFieldsWithRankValue(alexaWrapperInstance.alexaServiceWrapper, phPartner.ID);
		
		//Populating Account record with values
		phPartner.Alexa_Rank_Worldwide__c = alexaWrapperInstance.worldWideRank;
		
		//Update Ph-Partner
		update phPartner; 
		
    	//Return Back to Account Detail Page
 		pageRef = new PageReference('/' + phPartner.ID); 	
 		return pageRef;
    }
}