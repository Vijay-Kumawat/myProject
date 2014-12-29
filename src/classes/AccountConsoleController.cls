/*
* Description   : This is class to display account records on vf page.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 03/26/2013
*
* Version       : v1.0 - Create 
*/
public with sharing class AccountConsoleController {
    
    // Constructor
    public AccountConsoleController () {
        // Set the dropdown values.
        setAccStatuses();
        // Get cookie values.
        getCookies();
    }
    
    /* SIR Start */
    // Get all SIRs
    public transient List<Account> accList;
    public List<Account> getAccList() {
        accList = new List<Account>();
        accList = [Select Name , CustomerPriority__c , Phone , AccountNumber , NumberofLocations__c 
                        from    Account
                        where CustomerPriority__c in :selectedAccstatus
                        order by CreatedDate desc
                        limit 1000]; 
        return accList;
        
    }
    
    /* Account end */
    
    /* Account Status Filter Start */
    public List<SelectOption> sirStatusOptions {get; private set;}
    public List<String> selectedAccstatus {get; set;}
    
    // Set the Account Status
    public void setAccStatuses() {
        if(sirStatusOptions == null) {
            sirStatusOptions = new List<SelectOption>();
            selectedAccstatus = new List<String>();
            // Get SIR Picklist values.
            for(PicklistEntry pe : Account.CustomerPriority__c.getDescribe().getPicklistValues()) {
                sirStatusOptions.add(new SelectOption(pe.getValue(), pe.getLabel()));   
            }
        }
    }
    /* Account Status Filter End */
    
    public void filterData() {
        setCookies();
        accList = null;
    }
    
    /* Cookie Handler */
    // Get the Cookie values if any existing.
    public void getCookies() {
        
        String selectedAccstatuses = getCookieVal('accCookie');
        if(selectedAccstatuses != null && selectedAccstatuses != '') {
            selectedAccstatus = selectedAccstatuses.split(',');
        }
        
    }
    
    // Set the Cookies.
    public void setCookies() {
        
        String selectedAccstatuses = '';
        if(selectedAccstatus != null && selectedAccstatus.size() > 0) {
            for(String str : selectedAccstatus) {
                if(selectedAccstatuses != null && selectedAccstatuses != '') selectedAccstatuses += ',';
                selectedAccstatuses += str;
            }
        }
        Cookie accCookie = new Cookie('accCookie', selectedAccstatuses, null, 315569260, false);
        
        ApexPages.currentPage().setCookies(new Cookie[]{accCookie});
    }
    
    private String getCookieVal(String cookieName) {
        String cookieVal = '';
        Cookie cookie;
        cookie = ApexPages.currentPage().getCookies().get(cookieName);
        if(cookie != null)
            cookieVal = cookie.getValue();
        return cookieVal;
    }
    
    public PageReference createNewAcc() {
      String accKeyPrefix = Schema.SObjectType.Account.getKeyPrefix();
      PageReference accNewPage = new PageReference('/' + accKeyPrefix + '/e?retURL=' + URL.getCurrentRequestUrl().toExternalForm());
      accNewPage.setRedirect(true);
      return accNewPage;
    }
    /* END cookie Handler */
}