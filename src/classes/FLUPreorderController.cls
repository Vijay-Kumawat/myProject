/*
* Description	:	This is controller class for FLU Pre-order.
* 
* Created By    :	
*
* Created Date  :	09/21/2013
*
* Version       :	V_1.0 - Created 
*/

public class FLUPreorderController {

    //List to hold account records
    public List<Account> accountList{get; set;}
    
    //List to hold contact records
    public List<Contact> contactList{get; set;}
    
    //Map to hold string picklist values with price book entries
    public Map<String,List<PriceBookEntry>> mapProductFamilyWithPriceBookEntry{get; set;}
    public Map<String,List<PriceBookEntry>> mapProductFamilyWithPriceBookEntryUpdated{get; set;}
    
    //Variable
    public String pONumber {get; set;}
    public Id accountId;
    
    //Boolean variable
    public Boolean isAccountSuccessfullySave{get; set;}
    public Boolean isUnitPriceEqual {get; set;}
    public Boolean isEditable{get; set;}
    
    //Constructor
  	public FLUPreorderController(ApexPages.standardController controller){
  		
  		//Set the default values
  		isAccountSuccessfullySave = false;
  		isUnitPriceEqual = false;
  		isEditable = false;
  		
      	//Query to fetch account records
      	accountList = [SELECT ID, Name, AccountNumber, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet,  
                       BillingCity, BillingState, BillingPostalCode, Phone FROM Account];    
  	}
  	
  	//Method for displaying product records
  	public void showProducts() {
  		    
        //Initialize the map
  		mapProductFamilyWithPriceBookEntry = new Map<String,List<PriceBookEntry>>();
        
        //Query for Price Book Entry            
        for(PriceBookEntry pBE : [SELECT Id, Product2Id, Product2.Name, Product2.Besse__c, Product2.Age_Indication__c, Product2.Final_Price__c, 
        					      Product2.ENTER_YOUR_PRE_ORDER_UNITS__c, Product2.Dose_Unit__c, Product2.Total_Doses__c, Product2.Family, UnitPrice,
        					      Product2.July__c, Product2.August__c, Product2.September__c, Product2.October__c, Product2.November__c
        					      FROM PriceBookEntry WHERE Product2.IsActive = true AND PriceBook2.Name = 'Standard Price Book']) {
        	
        	//Check if map contains the key
 			if(mapProductFamilyWithPriceBookEntry.containsKey(pBE.Product2.Family)) {
 				
 				//populate the map list
 				mapProductFamilyWithPriceBookEntry.get(pBE.Product2.Family).add(pBE);
 			}
 			else
 				//populate the map with values where 'key' is the product family and 'value' is the price book entry
 				mapProductFamilyWithPriceBookEntry.put(pBE.Product2.Family , new List<PriceBookEntry>{pBE});
      	}
  	}
  	
  	//Method for save product recrods
  	public PageReference saveProducts() {
  		
  		//Initialize the map
  		mapProductFamilyWithPriceBookEntryUpdated = new Map<String,List<PriceBookEntry>>();
  		
  		//Loop through Price Book Entry list
  		for(List<PriceBookEntry> pBE : mapProductFamilyWithPriceBookEntry.values()) {
  			
  			//Inner loop 
  			for(PriceBookEntry p : pBE) {
  				
  		  		//Check if field value is not null
		  		if(p.Product2.ENTER_YOUR_PRE_ORDER_UNITS__c != null) {
		  			
		  			//Check if map contains the product family
					if(mapProductFamilyWithPriceBookEntryUpdated.containsKey(p.Product2.Family)) {
						
						//Add the value in the list
						mapProductFamilyWithPriceBookEntryUpdated.get(p.Product2.Family).add(p);
					
					} else {
						
						//populaet the map with values where 'key' is the product family and 'value' is the price book entry
						mapProductFamilyWithPriceBookEntryUpdated.put(p.Product2.Family , new List<PriceBookEntry>{p});
					}
		  		}
  			}
  		}
  		
  		//Page Reference for navigate to schedule shipping page
  		PageReference pageRef = new PageReference('/apex/FLUPreorderScheduleShipping?Id='+ ApexPages.CurrentPage().getParameters().get('Id'));
  		pageRef.setRedirect(false);
	  	return pageRef;
  	}
  	
  	//Method for validating unit price 
  	public PageReference validateUnitPrice() {
  		
  		//Loop through Price Book Entry list  
  		for(List<PriceBookEntry> pBE : mapProductFamilyWithPriceBookEntryUpdated.values()) {
  			
  			//Inner loop
  			for(PriceBookEntry p : pBE) {
  	
  				//Check if sum of all the months unit equal to the unit price
  				if(p.Product2.ENTER_YOUR_PRE_ORDER_UNITS__c != p.Product2.July__c + p.Product2.August__c + p.Product2.September__c + p.Product2.October__c + 
  				   p.Product2.November__c) {
  				   	
  				   	//Set the flag value
  				   	isUnitPriceEqual = true;
  				   	return null;
  				}
  			}
  		}
  		//Page Reference for navigate to contact preferences page
  		PageReference pageRef = new PageReference('/apex/FLUPreorderContactPreferences?Id='+ ApexPages.CurrentPage().getParameters().get('Id'));
  		pageRef.setRedirect(false);
	  	return pageRef;
  	}
  	
  	//Method for display contact records
  	public void showContacts() {
  		
  		//Get account id from url
  		accountId = ApexPages.CurrentPage().getParameters().get('Id');
  		
  		//Query to fetch contact record
  		contactList = [SELECT Id, PRIMARY_CONTACT__c, ADDTL_CONTACT__c, FirstName, LastName, Role__c, Phone, Email FROM Contact WHERE 
  					   AccountId =: accountId];
  	}
  	
  	//Method for update contact records
  	public PageReference updateContacts() {
  		
  		//Page Reference for navigate to review & submit page
  		PageReference pageRef = new PageReference('/apex/FLUPreorderReviewSubmit?Id='+ ApexPages.CurrentPage().getParameters().get('Id'));
  		pageRef.setRedirect(false);
	  	return pageRef;
  	}
}