/**
 *  Purpose         :   Controller class for EnhancedPropertyDetailView page
 * 
 *  Created By      :   
 * 
 *  Created Date    :   05/02/2013
 * 
 *  Revision Logs   :   V_1.0 - Created
 * 
 **/
public with sharing class DashboardTasksTestController {
    
    /*Public Properties */
    public Map<String , TabItems> tabItemsMap {get;set;}          
    
    /*Private Properties */
    private List<Contact> contactList;
    
    //Local Contact List Search Variable to holde Loccal Search
    private List<Contact> searchContactList{get; set;}
    
    //Hold Standard Set Controller Instance
    private Apexpages.Standardsetcontroller setController;
    
    //Hold Current Tab selected and Descide which Tab Item should be Affected
    public String operationFor{get; set;}
    
    //Hold Sobject Entity type 
    private SObjectType sEntity = Contact.getSObjectType();
    
    //Class Constructor
    public DashboardTasksTestController(){
        
        //Initialize Tab items Map
        tabItemsMap = new Map<String,TabItems>();
        
        //Initialize Contact List
        contactList =  new List<Contact>();
        
        //Default Operation will be for Seller Opportunity Object
        operationFor = 'Seller Opportunity';
        
        //Seller Oportunity Tab Data
        contactList = defaultList('Seller Opportunity');
        setController = new Apexpages.Standardsetcontroller(contactList);
        setController.setPageNumber(1);
        setController.setPageSize(10);
        tabItemsMap.put('Seller Opportunity',new TabItems(setController,contactList));
        
        //Sphere Opportunity
        contactList = defaultList('');
        setController = new Apexpages.Standardsetcontroller(contactList);
        setController.setPageNumber(1);
        setController.setPageSize(10);
        tabItemsMap.put('Sphere Opportunity',new TabItems(setController,contactList)); 
    }
    
    //============================================================= Methods ==========================================================================
    
    /** Method to Query Data with Deffault List Based On Critirea **/
    public List<Contact> defaultList(String criteria){
        
        //Get Query Contains all Filed of Contact
        //SObjectType entity = Contact.getSObjectType();
        
        String defaultSOQL = getSOQLQuery(sEntity);
        System.debug('Check for Criteria before Condition  ::::::::::::::: ' + criteria);
        if(criteria == 'Seller Opportunity'){
            
            System.debug('Check for Criteria In the Condition  ::::::::::::::: ' + criteria);
            defaultSOQL = defaultSOQL + ' where Seller_Status__c = \'Opportunity\'';    
        }
        System.debug('Check for Dynamic SOQL ::::::::::::::: ' + defaultSOQL);
        List<Contact> contactList = Database.query(defaultSOQL);
        
        return contactList;
    }
    
    /** Method to Get All Fields In Query **/
    public String getSOQLQuery(SObjectType  entity){
        
        String SOQL = 'select '+String.join(new list<String>(entity.getdescribe().fields.getmap().keyset()),',')+
                        ' from '+String.valueof(entity);
        
        return SOQL;
    }
    
    //================================================== Pagination Methods =========================================================================
    // All Of these Methods are belongs to User Actions Method 
    
    /** Go to Next Page */
    public void doNext(){
        
        if(tabItemsMap.containsKey(operationFor)){
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);
            if(item.setCont.getHasNext()){
                        
                item.setCont.next();
                resetSelectedStep();
            }
        }   
    }
    
    
    /* Go Previous */
    public void doPrevious(){
    
        if(tabItemsMap.containsKey(operationFor)){  
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);  
            if(item.setCont.getHasPrevious()){
                
                item.setCont.previous();
                resetSelectedStep();
            }
        }
    }
    
    /* Go to First Page */
    public void goFirst(){
        if(tabItemsMap.containsKey(operationFor)){  
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);  
            item.setCont.first();
        }   
    }
    /* Go to Last Page */
    public void goLast(){
        if(tabItemsMap.containsKey(operationFor)){  
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);  
            item.setCont.last();
        }
    }
    /* Method To Reset User Selected Steps */
    private void resetSelectedStep(){
        
        if(tabItemsMap.containsKey(operationFor)){
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);
            //userSelectedStep = this.setCon.getPageNumber();
            item.userSelectedStep = item.setCont.getPageNumber();           
        }
    }
    
    /** Switch To Step Dynamically **/
    public void switchToStep(){
        
        System.debug('Check for Operation Type $$$$$$$ '+ operationFor);
        if(tabItemsMap.containsKey(operationFor)){
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);
            //this.setCon.setpageNumber(userSelectedStep);
            item.setCont.setpageNumber(item.userSelectedStep);
        }   
    }
    
    /*Change page Size Dyamically */
    public void changePageSize(){
         
        if(tabItemsMap.containsKey(operationFor)){
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);
            
            System.debug('Check for Selected Page Size :::::::::::: ' + item.selectedSize);
            item.setCont.setPageSize(item.selectedSize); 
            switchToStep(); 
        }
    }
    
    //========================================================== Sorting Methods ====================================================================
    //User Action Method to Sort Data Dyanmically for Each Tab 
    public void sortView(){
        
        System.debug('Check for Operation Type ::::::::::::: ' + operationFor);
        
        if(tabItemsMap.containsKey(operationFor)){
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);
            if(item.sortDirection == 'ASC'){
          
              item.sortDirection = 'DESC' ;
            }else{
              
              item.sortDirection = 'ASC' ;
            }
              item.fullSortExp = item.sortValue + ' ' +   item.sortDirection ;
              
              executeQuery(item);
        }   
    }
    
    //Method to Sort Contact Dynamically
    private void executeQuery(TabItems item){
        
        //String soql = 'select Id, FirstName, LastName, Title, Phone, Email from Contact order by '+item.fullSortExp;  
        String soql;
        
        if(item.criteriaSearchList != null && item.criteriaSearchList.size()>0){
            
            soql = getSOQLQuery(sEntity).replace('otheraddress,','').replace('mailingaddress,','')+' where id IN: item.criteriaSearchList order by '+item.fullSortExp;
        }else{
            
            List<Contact> tempList = item.criteriaContactList;
            soql = getSOQLQuery(sEntity).replace('otheraddress,','').replace('mailingaddress,','')+' where id IN: tempList order by ' + item.fullSortExp;
        }
        try{
            
            contactList = Database.query(soql);
            
            //Initializing StandardSet Controller
            setController = new Apexpages.Standardsetcontroller(contactList);
            
        }catch(Exception e){
            Apexpages.addMessages(e);
        }
        
        item.setCont = setController;       
        item.setCont.setpageNumber(item.userSelectedStep);
        item.setCont.setPageSize(item.selectedSize);
        switchToStep();
    }
    
    //================================================ Searching Methods ===========================================================================
    
    public String searchText{get;set;}
    
    /* Dynamic Search In Contact Of whole oRg */
    public void doSearch(){
        
        String searchString;
        if(tabItemsMap.containsKey(operationFor)){
            
            //Get Tab Item
            TabItems item = tabItemsMap.get(operationFor);
            
            try{
                if(!String.isBlank(searchText.trim()) && searchText != null){
                
                    searchText = String.escapeSingleQuotes(searchText);
                    if(item.fullSortExp != null && !String.isBlank(item.fullSortExp))  {                   
                        
                        searchString =  'FIND \''+searchText+'*\' IN ALL FIELDS RETURNING Contact('+String.join(new list<String>(sEntity.getdescribe().fields.getmap().keyset()),',')+' order by '+ item.fullSortExp +')';
                    }else{
                        searchString =  'FIND \''+searchText+'*\' IN ALL FIELDS RETURNING Contact('+String.join(new list<String>(sEntity.getdescribe().fields.getmap().keyset()),',')+')';
                    }
                    List<List<SObject>>searchList=search.query(searchString);
                    item.criteriaSearchList = searchList[0];
                }else{
                    
                    if(item.fullSortExp != null)            
                        searchString = getSOQLQuery(sEntity).replace('otheraddress,','').replace('mailingaddress,','')+' where id IN: tempList order by ' + item.fullSortExp;   
                    else
                        searchString = getSOQLQuery(sEntity).replace('otheraddress,','').replace('mailingaddress,','')+' where id IN: tempList';
                    
                    item.criteriaSearchList = Database.query(searchString);
                }   
                
                contactList = item.criteriaSearchList;                      
            }catch(Exception e){
                
                Apexpages.addMessages(e);
            }
            //Initializing StandardSet Controller
            setController = new Apexpages.Standardsetcontroller(contactList);
            item.setCont = setController;       
            item.setCont.setPageSize(item.selectedSize);
            switchToStep();
        }
    }
    //================================================ Inner Classes ================================================================================
    
    /** Inner Class For Managing Contact List and Its Parameters **/
    public class TabItems{
        
        //Public Properties
        //Standard Set Controller
        public Apexpages.Standardsetcontroller setCont{get;set;}
        
        //Hold value for Field for Sorting
        public String sortValue {get;set ;}
        
        //Hold order of Sorting
        public String sortDirection{get;set;} 
        
        //Hold full expression for sorting
        public String fullSortExp{get; set;} 
        
        //Page Size
        public Integer selectedSize{get; set;}
        
        //User Selected Step
        public Integer userSelectedStep{get; set;}
        
        //Dummy Contact Object for Stage Selection option
        public Contact contactObj{get; set;}
        
        //List of Contact for Specifice criteria,It will be Initialized once
        public List<Contact> criteriaContactList;
        
        //List of Contact for Specifice Searched Data
        public List<Contact> criteriaSearchList;
        
        public TabItems(ApexPages.Standardsetcontroller setCont,List<Contact> contList){
            
            this.setCont = setCont;
            this.criteriaContactList = contList;
            
            userSelectedStep = 1;
            selectedSize = 10;
            
            //Initialize Contact
            contactObj = new Contact();
        }
        
        /* Return Current Page of Groups */
        public List<CCWRowItem> getContacts(){
            
            List<CCWRowItem> rows = new List<CCWRowItem>();
    
            for(Sobject r:this.setCont.getRecords()){
            
                Contact c = (Contact)r;
                CCWRowItem row = new CCWRowItem(c,false);
                /*if(selectedContactIds.contains(c.Id)){
                    row.isSelected = true;
                }else{
                    row.isSelected = false;
                }*/
                rows.add(row);
            }
            return rows;
        }
        
         /*
        *   return whether previous page exists
        */
        public Boolean getHasPrevious(){
     
            return this.setCont.getHasPrevious();
     
        }
     
        /*
        *   return whether next page exists
        */
        public Boolean getHasNext(){
     
            return this.setCont.getHasNext();
     
        }
        
         /*
        *   return page number
        */
        public Integer getPageNumber(){
     
            return this.setCont.getPageNumber();
     
        }
        
         /*
        *    return total pages
        */
        public Integer getTotalPages(){
     
            Decimal totalSize = this.setCont.getResultSize();
            Decimal pageSize = this.setCont.getPageSize();
     
            Decimal pages = totalSize/pageSize;
     
            return (Integer)pages.round(System.RoundingMode.CEILING);
        }
        
        /* List To hold Total Paging Numbers */ 
        public List<Integer> pagingNumbers{
            get{
                List<Integer> numbers = new List<Integer>();
                for(Integer i=1;i<=getTotalPages();i++){
                    numbers.add(i);
                }
                return numbers;       
            }
        }
    }
    
    /* Wrapper Class To Create Row Items */
    public class CCWRowItem{
            
        public Contact tContact{get;set;}
        public Boolean isSelected{get; set;}
        
        public CCWRowItem(Contact c, Boolean s){
            
            this.tContact = c;
            this.isSelected = s;
        }
    }
}