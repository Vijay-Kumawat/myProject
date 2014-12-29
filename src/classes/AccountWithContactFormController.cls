/**
 *  Description     :   This class is for the business card records to be saved in Account and Contact Object
 * 
 *  Created By      :   Bhavi Sharma 
 * 
 *  Created Date    :   03/1/2013
 * 
 *  Revision Logs   :   V_1.0 - Created
 *       
 **/
public without sharing class AccountWithContactFormController {
    
    //Account and Contact
    public Account account { get; set; }
    public Contact contact { get; set; }

    //Map to hold the potential duplicate accounts and contacts
	public Map<Id, Account> mapAccounts { get; set; }
	public Map<Id, Contact> mapContacts { get; set; }
    	        
	//Account and Contact for Merging
    public Account mergingAccount {get; set;}
    public Contact mergingContact {get; set;}
           
	//User Selection
	public Id selectedAccountId { get; set; }
	public String accountActionType { get; set; }
	public Id selectedContactId { get; set; }
	public String contactActionType { get; set; }
	public Boolean duplicateAccounts {get; set;}
	public Boolean duplicateContacts {get; set;}
	
	//Constructor
	public AccountWithContactFormController() {
		
		//Initialization
		contact = new Contact();
		
		//InIt
		inIt();
	}
	
	//Init Method
	private void inIt() {
                 
		//initializa data
		account = new Account();
		mergingAccount = new Account();
        mergingContact = new Contact();
        mapAccounts = new Map<Id, Account>();
		mapContacts = new Map<Id, Contact>();
		duplicateAccounts = false;
		duplicateContacts = false;    
	}
	
	/**
     * @Description  :  Method to search selected account for merge.
     *
     * @args         :  
     *
     * @return       :  void
     *
    **/   
    public PageReference getSelectedMergeAccount() {
    	
    	//Check for null  
    	if(selectedAccountId != null) {
    		
    		//Query to get account record
    		List<Account> accountsForMerging = [Select Id, Name, Website, OwnerId, BillingCity, BillingCountry From Account Where Id =: selectedAccountId];
    		
    		//Check for size
    		if(accountsForMerging.size() > 0) {
    			mergingAccount = accountsForMerging[0];
    			account.Id = mergingAccount.Id;
    			duplicateAccounts = true;
    		}
    	}   
    	return null;
    }
                
    /**
     * @Description  :  Method to search selected account for merge.
     *
     * @args         :  
     *
     * @return       :  void
     *
    **/   
    public PageReference getSelectedMergeContact() {
    	
    	//Check for null  
    	if(selectedContactId != null) {
    		
    		//Query to get contact record
    		List<Contact> contactsForMerging = [Select Id, LastName, OwnerId, Owner.Name, FirstName, Email, Phone, MobilePhone, Title,HasOptedOutOfEmail,Academic_TItle__c ,Note__c , OtherPhone, Business_Phone__c, Company__c, Email_Opt_Out__c, Gender__c, Skype__c, MailingStreet, MailingCity, MailingCountry, Mailingpostalcode, MailingState From Contact Where Id =: selectedContactId];
    
    		//Check for size
    		if(contactsForMerging.size() > 0) {
    			mergingContact = contactsForMerging[0];
    			contact.Id = mergingContact.Id;
    			contact.FirstName = contact.FirstName == '' ? '':contact.FirstName;
    			contact.HasOptedOutOfEmail = contact.HasOptedOutOfEmail == false ? false : contact.HasOptedOutOfEmail;
    			contact.Gender__c = contact.Gender__c == '' ? '' : contact.Gender__c;
    			contact.Title = contact.Title == '' ? '' : contact.Title;
    			contact.Skype__c = contact.Skype__c == '' ? '' : contact.Skype__c;
    			contact.Academic_TItle__c = contact.Academic_TItle__c == '' ? '' : contact.Academic_TItle__c;
    			contact.MailingStreet = contact.MailingStreet == '' ? '' : contact.MailingStreet;
    			contact.MailingCity = contact.MailingCity == '' ? '' : contact.MailingCity;
    			contact.Business_Phone__c = contact.Business_Phone__c == '' ? '' : contact.Business_Phone__c;
    			contact.MailingCountry = contact.MailingCountry == '' ? '' : contact.MailingCountry;
    			contact.MobilePhone = contact.MobilePhone == '' ? '' : contact.MobilePhone;
    			contact.MailingPostalCode = contact.MailingPostalCode == '' ? '' : contact.MailingPostalCode;
    			contact.OtherPhone = contact.OtherPhone == '' ? '' : contact.OtherPhone;
    			contact.Note__c = contact.Note__c == '' ? '' : contact.Note__c;
    			duplicateContacts = true;
    		}
    	}
    	return null;
    }
	
	/**
	 *	@description	:	This method is to check 
 								1. If there is any  existing account or/and contact with the same information as entered on UI
 								2. If nothing exists already, insert directly
	 * 
	 * 	@args			:	
	 * 
	 * 	@return			:	void		
	 * 
	 **/
	public void validateInsert() {
        
		try {
			
			//Search for the potential duplicate accounts and contacts
			mapAccounts = getMapAccounts(account);
			mapContacts = getMapContacts(contact);
			
			//Check if any duplicate data was searched
			if(mapAccounts.size() > 0 || mapContacts.size() > 0) {
				
				//Add warning
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning, 'Potential duplicates found. You can update existing accounts and contacts using "Override All/Override Blank/Merge" functionality. Please click on help link to get more information about each action in detail.'));
				
				//Check if existing account is there
				if(mapAccounts.size() > 0)
						duplicateAccounts = true;
				if(mapContacts.size() > 0)
					duplicateContacts = true;
				return;
			}
		    
			//Insert data if no duplicate
			save();
		} catch (Exception e) {
			
			//Add error on page
			ApexPages.addMessages(e);
		}
	}
	
	/**
	 * 	@description	:	This method is to insert/update data in database
	 * 
	 * 	@args			:	
	 * 
	 * 	@return			:	void
	 * 
	 **/
	public void save() {
		
		//Create a savepoint
		Savepoint sp = Database.setSavepoint();
		
		try {
			
			//Get Account record type
			//RecordType rType = [Select Id, Name From RecordType Where SObjectType =: 'Account' AND DeveloperName =: 'Non_Investee_Accounts' LIMIT 1];
			
			//Set default record type for account
			//account.RecordTypeId = rType.Id;
			
			//Set account owner
			account.OwnerId = contact.OwnerId;
			
			//Upsert account
			upsert account;
			
			//Populate the latest account instance in contact
			contact.AccountId = account.Id;
			
			//Get Contact record type
			//rType = [Select Id, Name From RecordType Where SObjectType =: 'Contact' AND DeveloperName =: 'General' LIMIT 1];
	        
			//Set default record type for contact
			//contact.RecordTypeId = rType.Id;
			upsert contact;
			        
			//Success message
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Information has been saved successfully.'));
			
			//Set default owner for the new business card
			contact = new Contact(OwnerId = contact.OwnerId);
			
			//reload everything
			inIt();
		} catch(Exception e) {
		
			//Rollback the complete transaction in case of exception
			database.rollBack(sp);	
		    			
			//Add error on page        
			ApexPages.addMessages(e);       
		}
	}
    
    /**
	 * 	@description	:	This method is to insert/update data in database when duplicates were found
	 * 
	 * 	@args			:	Account and Contact instance
	 * 
	 * 	@return			:	void
	 * 
	 **/
	public void manualSubmit() {
		
		//Validate user action
		updateRecordInstance();
		
		//Save data
		save();
	}
    
    /**
     * 	@description	:	This method is to search the exisitng accounts
     * 
     * 	@args			:	Account instance
     * 
     * 	@return			:	Map of accounts
     * 
     **/
    private Map<Id, Account> getMapAccounts(Account accountObject) {
    	
    	//Account Map
    	Map<Id, Account> mapPDAccounts = new Map<Id, Account>();
    	duplicateAccounts = false;
    	
    	//Account Information
		String accountName = accountObject.Name;
		String website = accountObject.Website;
		
		//Account Query
		String SOQLQuery = 'Select Id ';
		
		//fetch fields from fieldset to support the dynamic behaviour
		for(Schema.FieldSetMember f : SObjectType.Account.FieldSets.Business_Card.getFields())
            SOQLQuery += ', ' + f.getFieldPath();
        SOQLQuery += ' FROM Account ';
        
        //Check for the account name
        if(!String.IsBlank(accountName) || !String.IsBlank(website)) {
        	
        	//Where clause criteria
        	String whereClauseCriteria = ' where ';
        	if(!String.IsBlank(accountName) && accountName.length() >= 4) {
        		
        		//Allow the like search if there are 4 or more than 4 characters
        		accountName = '%' + accountName + '%';
        		whereClauseCriteria += ' Name like \'' + accountName + '\' AND ';
        	} else if(!String.IsBlank(accountName)) {
        		
        		//In case of less than 4 characters, do the exact search
        		whereClauseCriteria += ' Name = \'' + accountName + '\' AND ';
        	}
        	
        	//Website check
        	if(!String.IsBlank(website) && website.length() >= 4) {
        		
        		//Allow the like search if there are 4 or more than 4 characters
        		website = '%' + website + '%';
        		whereClauseCriteria += ' Website like \'' + website + '\' AND ';
        	} else if(!String.IsBlank(website)) {
        		
        		//In case of less than 4 characters, do the exact search
        		whereClauseCriteria += ' Website = \'' + website + '\' AND ';
        	}
        	
        	//Ending with AND keyword
        	SOQLQuery = SOQLQuery + whereClauseCriteria.removeEnd(' AND ');
        	
        	//Query data from data base
        	System.debug('SOQLQuery is: ' + SOQLQuery);
        	mapPDAccounts = new Map<Id, Account>((List<Account>)database.query(SOQLQuery));
        	if(mapPDAccounts.size() > 0)
        		duplicateAccounts = true;
        }
        return mapPDAccounts;
    }
    
    /**
     * 	@description	:	This method is to search the exisitng contacts
     * 
     * 	@args			:	Contact instance
     * 
     * 	@return			:	Map of accounts
     * 
     **/
   private Map<Id, Contact> getMapContacts(Contact contactObject) {
    	
    	//Contact Map
    	Map<Id, Contact> mapPDContacts = new Map<Id, Contact>();
    	duplicateContacts = false;
    	
    	//Contact Information
		String email = contactObject.Email;
		String phone = contactObject.Phone;
		
		//Contact Query
		String SOQLQuery = 'Select Id ';
		
		//fetch fields from fieldset to support the dynamic behaviour
		for(Schema.FieldSetMember f : SObjectType.Contact.FieldSets.Business_Card.getFields())
            SOQLQuery += ', ' + f.getFieldPath();
        SOQLQuery += ' FROM Contact ';
        
        //Check for the Email
        if(!String.IsBlank(email) || !String.IsBlank(phone)) {
        	
        	//Where clause criteria
        	String whereClauseCriteria = ' where ';
        	if(!String.IsBlank(email)) {
        		
        		//In case of less than 4 characters, do the exact search
        		whereClauseCriteria += ' Email = \'' + email + '\' AND ';
        	}
        	
        	//Check for Phone
        	if(!String.IsBlank(phone)) {
        		
        		//In case of less than 4 characters, do the exact search
        		whereClauseCriteria += ' Phone = \'' + phone + '\' AND ';
        	}
        	
        	//Ending with AND keyword
        	SOQLQuery = SOQLQuery + whereClauseCriteria.removeEnd(' AND ');
        	
        	//Query data from data base
        	System.debug('SOQLQuery is: ' + SOQLQuery);
        	mapPDContacts = new Map<Id, Contact>((List<Contact>)database.query(SOQLQuery));
        	if(mapPDContacts.size() > 0)
        		duplicateContacts = true;
        }
        return mapPDContacts;
    }
    
    /**
     *	@description	:	This method is to update the account and contact instance based on the selected action
     *
     *	@args			:
     *
     *	@return			:	Void
     *
     **/
    private void updateRecordInstance() {
    	
    	//Check if account record was selected
    	if(selectedAccountId != null && !String.IsBlank(accountActionType)) {
    		
    		//Update the main instance with the user selection
    		Account selectedAccount = mapAccounts.get(selectedAccountId);
    		
    		//override all the existing information if Override All is selected
    		if(accountActionType == 'oAll') {
    			
    			//Override all
    			account.Id = selectedAccount.Id;
    		} else if(accountActionType == 'oBlank') {
    			
    			//Override blank
    			if(String.IsBlank(selectedAccount.Website))
    				selectedAccount.Website = account.Website;
    				
    			//Update account instance
    			account = selectedAccount;
    		}
    	}
    
    	//Check for account action type
    	if(accountActionType == 'unCheck') {
        		
    		//Clone account record
    		account = account.clone(false);
    	}
    	     
    	//Check for contact action type
    	if(contactActionType == 'unCheck') {
    		
    		//Clone contact record
    		contact = contact.clone(false);
    	}
    	
    	//Check if Contact record was selected
    	if(selectedContactId != null && !String.IsBlank(contactActionType)) {
    		
    		//Update the main instance with the user selection
    		Contact selectedContact = mapContacts.get(selectedContactId);
    		
    		//override all the existing information if Override All is selected
    		if(contactActionType == 'oAll') {
    			
    			//Override all
    			contact.Id = selectedContact.Id;
    		} else if(contactActionType == 'oBlank') {
    			
    			//Override blank information
    			if(String.IsBlank(selectedContact.FirstName))
    				selectedContact.FirstName = contact.FirstName;
    			if(String.IsBlank(selectedContact.Title))
    				selectedContact.Title = contact.Title;
    			if(String.IsBlank(selectedContact.Academic_TItle__c))
    				selectedContact.Academic_TItle__c = contact.Academic_TItle__c;
    			if(String.IsBlank(selectedContact.Business_Phone__c))
    				selectedContact.Business_Phone__c = contact.Business_Phone__c;
    			if(String.IsBlank(selectedContact.MobilePhone))
    				selectedContact.MobilePhone = contact.MobilePhone;
    			if(String.IsBlank(selectedContact.OtherPhone))
    				selectedContact.OtherPhone = contact.OtherPhone;
    			if(String.IsBlank(selectedContact.Gender__c))
    				selectedContact.Gender__c = contact.Gender__c;
    			if(String.IsBlank(selectedContact.Skype__c))
    				selectedContact.Skype__c = contact.Skype__c;
    			if(String.IsBlank(selectedContact.MailingStreet))
    				selectedContact.MailingStreet = contact.MailingStreet;
    			if(String.IsBlank(selectedContact.MailingCity))
    				selectedContact.MailingCity = contact.MailingCity;
    			if(String.IsBlank(selectedContact.MailingCountry))
    				selectedContact.MailingCountry = contact.MailingCountry;
    			if(String.IsBlank(selectedContact.Mailingpostalcode))
    				selectedContact.Mailingpostalcode = contact.Mailingpostalcode;
    			if(String.IsBlank(selectedContact.Note__c))
    				selectedContact.Note__c = contact.Note__c;
    				
    			//Update account instance
    			contact = selectedContact;
    		} 
    	}	
    }
}