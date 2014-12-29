/*
* Description   : This is class there to perform Account Advance Search Functionality with the hepl of standard controller.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 02/24/2012
*
* Version       : v1.0 - Create 
*/

public class AccountDetailsWithPageReference {

    //String to hold header
    public Map<String,String> headerMap {get;set;}
    public String url {get ; set;}
    public Map<String,String> parameterMap {get;set;} 
    public String ancher {get;set;}
    
    //Constructor
    public AccountDetailsWithPageReference(ApexPages.StandardController controller) {
    
        PageReference pageRef = ApexPages.CurrentPage();
    
        url  = pageRef.getURL();
        
        headerMap = new Map<String,String>();
        
        headerMap = pageRef.getHeaders();
        
        parameterMap = new Map<String,String>();
        
        parameterMap = pageRef.getParameters();
        
        ancher = pageRef.getAnchor();
       
    }
    
}