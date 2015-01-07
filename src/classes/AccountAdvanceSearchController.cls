/*
* Description   : This is class there to perform Account Advance Search Functionality with the hepl of standard controller.
* 
* Created By    : Vijay Kumar Kumawat (Simplyforce)
* 
* Created Date  : 10/09/2012
*
* Version       : v1.0 - Create Testing For Test
*/

public class AccountAdvanceSearchController {

    //List to hold Account Records
    public List<Account> accounts {get; set;}
    
    //Account
    public Account account {get; set;}
    
    //Constructor
    public AccountAdvanceSearchController(ApexPages.StandardController controller) {
        
       //Getting records for account
       account = (Account)controller.getRecord();
    }
    
    //Method responsible for search functionality
    public void search() {
    
        //String to hold the String of fields Name from the set
        String fieldSetString = '';
    
        //List to hold all the members of field set
        List<Schema.FieldSetMember> fields = Schema.SObjectType.Account.fieldSets.FieldSetSearch.getFields();
           
        //Loop through List of FieldSetMembers
        for(Schema.FieldSetMember f1 : fields) {
        
           //Populate the string with fields Name are in FieldSet
           fieldSetString += f1.getFieldPath() + ', ';
           
        }
        
        //Trim the string
        fieldSetString = fieldSetString.trim();
        
        //Removal of ',' from the End
        fieldSetString = fieldSetString.removeEnd(',');
        
        //Query for the data from the database
        String SOQLQuery = 'SELECT Id, Name,' + fieldSetString + ' '  + 'FROM Account WHERE';
        
        //Loop through List of FieldSetMembers
        for(Schema.FieldSetMember f1 : fields) { 
        
            String str = f1.getFieldPath();
            
            //Check for null
            if(account.get(str) != null && account.get(str) != '') {
            
                //Modify SOQL query
                SOQLQuery += ' ' + Str + ' ' + 'Like \'' + account.get(str) + '%\'';
                
                SOQLQuery += ' ' + 'AND';
            }
        }
        
        //trim string
        SOQLQuery = SOQLQuery.trim();
        
        //Check if SOQLQuery ends with AND
        if(SOQLQuery.endsWith('AND'))
        SOQLQuery = SOQLQuery.subString(0, SOQLQuery.lastIndexOf('AND'));
        
        //Query data from datebase
        accounts = database.query(SOQLQuery);
    }
}
