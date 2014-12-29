/**
 *  Description     :   Helper class for Lead trigger.
 *
 *  Created Date    :   06/18/2013
 * 
 *  Revision Logs   :   V1.0 - Created                    
 **/
public with sharing class LeadTriggerHelper {
  
    //Method responsible for update account records data through web service callout from salesforce to alexa
    public static void updateLeadDataFromAlexaResponse(List<Lead> newLeads) {
    
        //Getting the first element for the list
        Lead lead = newLeads[0];
    
        //Checking for Website field value
        if(lead.Site_URL__c != null || lead.Site_URL__c != '') {
          
            //Make the webservice callout using future method.
            if(!System.isFuture() && !System.isBatch()) {
                
                //Calling future method to make the web service callouts
                //FutureCallHandler.updateLeadWithAlexaResponse(lead.Site_URL__c, lead.ID);
            }
        }
    }
}