public without sharing class AccountContactInfoController {
    
    //properties
    public Account account {get; set;}
    public Contact contact {get; set;}
    public Contact newlyInsertedContact {get; set;}
    
    //Boolean variables
    public Boolean isAccountCreated {get; set;}
    public Boolean isContactCreated {get; set;}
    public Boolean isPreview {get; set;}
    
    //Constructor calling
    public AccountContactInfoController(ApexPages.StandardController controler){
        
        account = new Account();
        contact = new Contact();
        newlyInsertedContact = new Contact();
        isAccountCreated = true;
        isContactCreated = false;
        isPreview = false;
    }
    
    //This method is for save account record
    public void saveAccount() {
        
        try {
            
            //insert account
            insert account;
            
            //Set the flag value
            isAccountCreated = false;
            isContactCreated = true;
            isPreview = false;
        } catch(Exception e) {
            
            ApexPages.addMessages(e);
        }
    }
    
    //This method is for save contact record
    public void saveContact() {
        
        try {
            
            //populate contact with account id
            contact.AccountId = account.ID;
            
            //insert contact
            insert contact;
            
            //List to hold contact record
            List<Contact> listContact = [SELECT FirstName , LastName , Email , Phone , MailingStreet , MailingCity , MailingState , MailingCountry , MailingPostalCode , 
                                         OtherStreet , OtherCity , OtherState , OtherCountry , OtherPostalCode , Description , account.Name , account.AccountNumber , 
                                         account.Type , account.Phone , account.ShippingStreet , account.ShippingCity , account.ShippingState , account.ShippingCountry , 
                                         account.ShippingPostalCode , account.BillingStreet , account.BillingCity , account.BillingState , account.BillingCountry , 
                                         account.BillingPostalCode , account.Description FROM Contact WHERE ID =:contact.ID LIMIT 1];
            
            //Check for size
            if(listContact.size() > 0)
                newlyInsertedContact = listContact[0];
            
            //Set the flag value
            isPreview = true;
            isAccountCreated = false;
            isContactCreated = false;
        } catch(Exception e) {
            
            ApexPages.addMessages(e);
        }
    }
    
    //This method is for redirect user to account tab view
    public PageReference returnToAccount() {
        
        return new PageReference('/001/o');
    }
    
    //This method is for update account record
    public void updateAccount() {
        
        try {
            
            //update account
            update newlyInsertedContact.Account;
            
        } catch(Exception e) {
            
            ApexPages.addMessages(e);
        }
    }
}