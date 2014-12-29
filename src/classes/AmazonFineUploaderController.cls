public with sharing class AmazonFineUploaderController {

	//String to hold Account Id
	public String accountId {get; set;}
	
	//Constructor Calling
	public AmazonFineUploaderController() {
		
		//Get Account Id From URL
		accountId = ApexPages.currentPage().getParameters().get('Id');
	}
	
	//Save Document in Salesforce
	public void saveDocument() {
		
		
	}
}