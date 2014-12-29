/*
* Description   : This is class there to perform Account Search Functionality.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 03/5/2013
*
* Version       : v1.0 - Create 
*/

//Class
public class AccountSearch{

    //List to hold Conatct records
    public List<Account> accountList{get; set;}
    
    //Variable to hold page size
    public Integer pageSize {get; set;}
    
    //String to Hold SOQL Query
    public String soqlQuery;
    
    //Account
    Account account;
    
    //Calling Constructor
    public AccountSearch(ApexPages.StandardController Controller){
    
        //Initialize List
        accountList = new List<Account>();
        
        //Initailize Account
        account = (Account)Controller.getRecord();
        
        
    }
    
    //Method for going to next page
    public Void next() {
        next();
            }
            
    public void previous() {  
        previous(); 
        }
            
        //Method For Search
        public void search(){
        
        //Initialize the page size
        pageSize = 4;
            
            //Query to fetch records from database
            soqlQuery = 'SELECT Id, Name, Phone , Fax , AccountNumber, CustomerPriority__c FROM Account WHERE';
            
            if(account.Name != Null && account.Name != '') {
            
                soqlQuery += ' Name like \'' +account.Name.replaceAll('\\*','%')+ '%\' AND';
            }   

            if(account.Phone != Null && account.Phone != '') {
                
                soqlQuery += ' Phone like \'' +account.Phone.replaceAll('\\*','%')+ '%\' AND';
            } 
            
            if(account.AccountNumber != Null && account.AccountNumber != '') {
                
                soqlQuery += ' AccountNumber like \'' +account.AccountNumber.replaceAll('\\*','%')+ '%\' AND';
            } 
            
            if(account.CustomerPriority__c != Null) {
                
                soqlQuery += ' CustomerPriority__c like \'' +account.CustomerPriority__c.replaceAll('\\*','%')+ '%\' AND';
            } 
            
            if(account.Brand_Customer__c != Null) {
                
                soqlQuery += ' Brand_Customer__c = \'' + account.Brand_Customer__c + '\' AND';
            } 
            
            if(account.ChooseOption__c != Null) {
                
                soqlQuery += ' ChooseOption__c includes(\'' + account.ChooseOption__c + '\') AND';
            } 
            
            if(account.Account_Created_Date__c != Null) {
                
                soqlQuery += ' Account_Created_Date__c = ' + account.Account_Created_Date__c.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') + 'AND';
                
            } 
            
            if(account.Account_Owner_Email__c != Null) {
                
                soqlQuery += ' Account_Owner_Email__c like \'' +account.Account_Owner_Email__c.replaceAll('\\*','%')+ '%\' AND';
            } 
            
            //Trim String
            soqlQuery = soqlQuery.trim();
        
             if(soqlQuery.endsWith('AND')) {
             soqlQuery = soqlQuery.subString(0, soqlQuery.lastIndexOf('AND')); 
           
             } 
             
             //Check for the Null string
             if(soqlQuery.endsWith('WHERE') == false) {
                 
                //Populate List with Values
                accountList = database.query(soqlQuery);
                
             }
             
             else {
                 //Add error on page as Please select atleast one criteria
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.SELECT_CRITERIA)); 
             }
        }
}