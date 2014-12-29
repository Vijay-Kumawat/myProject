/*
* Description   : This is class there to perform Conatact Search Functionality.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 1/15/2013
*
* Version       : v1.0 - Create 
*/

//Class
public class ContactSearchFunctionality{

    //List to hold Conatct records
    public List<Contact> contactList{get; set;}
    
    //String to Hold SOQL Query
    public String soqlQuery;
    
    //Contact
    Contact contact;
    
    //Calling Constructor
    public ContactSearchFunctionality(ApexPages.StandardController Controller){
    
    //Initialize List
    contactList = new List<Contact>();
    
    //Initailize Contacts
    contact = (Contact)Controller.getRecord();
    
    }
        //Method For Search
        public void search(){
        
            soqlQuery = 'SELECT Id, Name, FirstName , LastName , Phone , Email, Account.Name, Account.AccountNumber FROM Contact WHERE';
            
            if(contact.Name != Null && contact.Name != '') {
            
            soqlQuery += ' Name like \'' +contact.Name.replaceAll('\\*','%')+ '%\' AND';
            }   
            
            if(contact.Email != Null && contact.Email != '') {
                
                soqlQuery += ' Email like \'' +contact.Email.replaceAll('\\*','%')+ '%\' AND';
            }  
            
            if(contact.Account.Name != Null && contact.Account.Name != '') {
                
                soqlQuery += ' Email like \'' +contact.Account.Name.replaceAll('\\*','%')+ '%\' AND';
            } 
            
            if(contact.Account.AccountNumber != Null && contact.Account.AccountNumber != '') {
                
                soqlQuery += ' Email like \'' +contact.Account.AccountNumber.replaceAll('\\*','%')+ '%\' AND';
            } 
            
            //Trim String
            soqlQuery = soqlQuery.trim();
        
             if(soqlQuery.endsWith('AND')) {
             soqlQuery = soqlQuery.subString(0, soqlQuery.lastIndexOf('AND')); 
           
             }
            
        //Populate List with Values
        contactList = database.query(soqlQuery);
    
        }
}