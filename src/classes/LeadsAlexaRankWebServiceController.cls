/**
 *  Description     :   Apex class having logic for Alexa web service callout through custom button for Lead object.
 *
 *  Created Date    :   06/18/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
public with sharing class LeadsAlexaRankWebServiceController {
	
	//String to hold Lead Site URL field value
    String leadSiteURL;
    
    //Wrapper Instance
    public AlexaServiceWrapper alexaWrapperInstance {get; set;}

    //Boolean variable is going to be helpful in rerendering
    public Boolean isRequestValid {get; set;}
    
    //Variable to hold the Pagereference
    PageReference pageRef;
    
    //Account Instance
    Lead lead;
    
    //Calling constructor
    public LeadsAlexaRankWebServiceController(ApexPages.StandardController controller) {
    	
    	//Getting Lead record
    	lead = (Lead)controller.getRecord();
    	
    	//Setting value of flag
    	isRequestValid = true;
    	
    	//Validating for Presence of lead record
    	if(lead != null) {
    	
	    	//Getting Lead Site URL value corresponding to the Id value
	    	leadSiteURL = [SELECT ID, Site_URL__c FROM Lead WHERE ID =: lead.ID LIMIT 1].Site_URL__c;
    	}
    	
    	//Getting Wrapper populated with the values returned by the web service 
  		alexaWrapperInstance = JSONParserBuilder.parseJSONForResponseValues(leadSiteURL);
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
    	
    	//populating Lead with values
		lead = Utility.populateLeadRankFieldsWithNull(lead.ID);
		
        //Update Account
    	update lead;
    		
    	//Return Back to Account Detail Page
 		pageRef = new PageReference('/' + lead.ID); 	
 		return pageRef;
    }
    
    //Method to populate Alexa fields on lead record with values returned by the web service
    public Pagereference saveInformationToLead() {
    	
    	//Setting value of flag
    	isRequestValid = true;
			 
		//Getting Lead populated with individual Rank field values
		lead = Utility.populateLeadAlexaFieldsWithRankValue(alexaWrapperInstance.alexaServiceWrapper, lead.ID);
		
		//Populating Account record with values
		lead.Alexa_Rank_Worldwide__c = alexaWrapperInstance.worldWideRank;
		
		//Update Ph-Partner
		update lead; 
		
    	//Return Back to Account Detail Page
 		pageRef = new PageReference('/' + lead.Id); 	
 		return pageRef;
    }
}