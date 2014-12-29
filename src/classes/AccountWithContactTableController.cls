public with sharing class AccountWithContactTableController {
	
	//List to hold contact records
	public List<Contact> contacts {get; set;}
	
	//Properties
	public Decimal totalContactAmount {get; set;}
	public Decimal totalAccountAmount {get; set;}
	public Decimal differenceAmount {get; set;}
	
	//Constructor Calling
	public AccountWithContactTableController(ApexPages.StandardController controller) {
		
		//Initialization
		contacts = new List<Contact>();
		totalContactAmount = 0;
		totalAccountAmount = 0;
		differenceAmount = 0;
		
		//Get account record
		Account account = (Account)controller.getRecord();
		
		totalAccountAmount = account.Amount__c;
		
		//Query to get contact record
		for(Contact con : [Select Id, FirstName, LastName, Amount__c From Contact Where AccountId =: account.Id]) {
			
			//Populate the list
			contacts.add(con);
			
			//Calculate total amount
			totalContactAmount += con.Amount__c;
		}
		
		//Calculate difference
		differenceAmount = totalAccountAmount - totalContactAmount;
	}
}