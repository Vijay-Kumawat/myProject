/*
*   Description   :   This class is there to perform Account Advanced Search Functionality.
* 
*   Created By    :   Vijay Kumar Kumawat
*
*   Created Date  :   10/08/2012
*
*   Version       : v1.0 - Create
*
*/
       
public class MyAccountSearchController {
    
    //List to hold Account records
    public List<Account> accounts{get;set;}
    
    //Variable to help rendered on page
    public Boolean isRender {get; set;}
    
    //Strings Enter by User on Page through Input Text
    
    public string accountName {get; set;}
    public string billingCity {get; set;}
    public string billingState {get; set;}
    public String accountNumber {get; set;}
    public string billingCountry {get; set;}
    
    
    //Calling Constructor
    public MyAccountSearchController() {
        
        //Set Boolean Variable Value
        isRender = false;
    }
    
    //Calling Method for Search
    public  void search(){
        
        //SOQL Query String
        String str = 'SELECT Id, Name, BillingCity, BillingState, AccountNumber, BillingCountry FROM Account Where Name like \'' +accountName+ '%\' AND BillingCity like \'' +billingCity+ '%\' AND BillingState like \'' +billingState+ '%\' AND AccountNumber like \'' +accountNumber+ '%\' AND BillingCountry like \'' +billingCountry+ '%\'';
        
        //Populate List with records
        accounts = Database.query(str);
        
        //Check for size of list
        if(accounts.size() >0 && accountName != '') {
            isRender = true;    
        }else {
            isRender = false;
        }
    }
}