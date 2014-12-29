/*
* Description   : This is controller class for Register New Deal in salesforce.
* 
* Created By    : 
*
* Created Date  : 10/02/2014
*
* Version       : V_1.0 - Created 
*/

public without sharing class RegisterNewDealController {

	//Create properties
	public Lead lead{get; set;}
	
	//Constructor
	public RegisterNewDealController() {
		
		//Initialize
		lead = new Lead();
	}
	
	//This method is for save lead data
	public PageReference saveLeadInfo() {
		
		try {			
			//populate lead fields default
			lead.Company = 'Test';
			lead.LeadSource = 'Registered Deal';
			lead.Submitted_By__c = UserInfo.getUserId();
			lead.Status = 'Waiting Approval';
			
			//Insert data
			insert lead;
			
			return new PageReference('/'+ lead.Id);
		} catch(Exception e) {
			
			//Add error message
			apexPages.addMessages(e);
			return null;
		}
	}
	
	//This method is for redirect user to home page
	public PageReference redirectToHome() {
		
		return new PageReference('/home/home.jsp');
	}
}