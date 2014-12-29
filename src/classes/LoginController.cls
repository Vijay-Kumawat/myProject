/** 
  * Description     :   Login Page controller for the Developer and the Client separate pages for them for there Time sheet records.
  *
  * Created By      :   Abhi Tripathi (Simplyforce Technology)
  *                
  * Created Date    :   2/4/2014    
  *
  * Revision Log    :   V1.0
  **/
public without sharing class LoginController {
      
    //Email Id and Password
    public String emailId { get; set; }  
    public String password { get; set; }
    private Date dt;
    public Date startOfWeek { get; set; }
    String contactId = '';
    public Integer noOfRows { get; set; }
        
    //Company related variables
    public Company__c company { get; set; }
    public List<Company__c> companies { get; set; }
    public List<Company__c> companiesList { get; set; }
    public List<Company__c> forMoreEntryCompanies { get; set; }
    public Map<Id, List<Company__c>> workStatusRecordsCreatedThisWeek { get; set; }
    
    //Project related variables
    public String selectedProject { get; set; }
    public Project__c carrier { get; set; }
    public List<SelectOption> options { get; set; }
    
    //Boolean to check user is logged in or not    
    public Boolean isLoggedIn { get; set; }
    public Boolean isClient { get; set; }
    public String userName { get; set; }
    String client = '';

    /**
     * @Description  :  Constructor fetching contact Id and isClient boolean value and querying Project records to populate the picklist.
     *
     * @args         :  
     *
     * @return       :  
     *
    **/        
    public LoginController() {
        
        isLoggedIn = false;
        isClient = false;
        
        //Initiallizing the variables
        emailId = '';
        password = '';
        selectedProject  = '';
        noOfRows = 0;
        carrier = new Project__c();
        options = new List<SelectOption>();
        companies = new List<Company__c>();
        companiesList = new List<Company__c>(); 
        forMoreEntryCompanies = new List<Company__c>(); 
        workStatusRecordsCreatedThisWeek = new Map<Id, List<Company__c>>(); 
        
        //Adding option a blank values
        options.add(new SelectOption('','--Select Project--'));  
    }

    /**
     * @Description  :  Method used when user tries to get loggin like matching UserName and Password and checking weather its a Developer or Client.
     *
     * @args         :  
     *
     * @return       :  PageReference
     *
    **/    
    public PageReference login() {

        contactId = '';
        client = '';
        List<Contact> contact = new List<Contact>();
        
        //Check the values entered by the user
        if(emailId != Null && emailId != '' && password != Null && password != '') {
                  
            //Query on Contact records Weather the email id Entered by the user exists
            contact = [ Select Email, IsClient__c, Password__c From Contact Where Email =: emailId LIMIT 1];
            
            //Check for Contact
            if(contact.size() > 0) {
            
                //Comparing password from the database
                if( contact[0].Password__c.compareTo(password) == 0 && contact[0].IsClient__c == False) {
                    
                    //Get todays day name
                    Date d = System.today();
                    Datetime dt = (DateTime)d;
                    String dayOfWeek = dt.format('EEEE');
                     
                        isLoggedIn = true;  
                        isClient = false;  
                        contactId = contact[0].Id;
                        client = 'false';

                        //Calling method
                        populateProjectSelectlist(contactId, client);
                        
                        //Page Url set
                        PageReference newPage = New PageReference('/apex/DeveloperTimeSheet');

                        //Reinitiallize all the atribute by this
                        newPage.setRedirect(false);
                        
                        //Return to page
                        return newPage;
            
                } else if( contact[0].Password__c.compareTo(password) == 0 && contact[0].IsClient__c == True) {
                
                    isLoggedIn = true;  
                    isClient = true;
                    contactId = contact[0].Id;
                    client = 'true';

                    //Calling method
                    populateProjectSelectlist(contactId, client);
                        
                    //Page Url set
                    PageReference newPage = New PageReference('/apex/TimeSheetForClient');
                    
                    //Reinitiallize all the atribute by this
                    newPage.setRedirect(false);
                        
                    //Return to page
                    return newPage;
                
                } else {
                    
                    //Message method when no field is filled
                    //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, Constants.ERROR_MESSAGE_2 ));
                }
            } else {
                
                //Message method when no field is filled
                //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Constants.ERROR_MESSAGE_3 ));  
            }
        } else {
            
            //Message method when no field is filled
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Constants.ERROR_MESSAGE_4));
        }
        
        return null;
    }

    /**
     * @Description  :  Method to check weather the user is Logged in or not.
     *
     * @args         :  
     *
     * @return       :  void
     *
    **/    
    public void pageRef() {
        
        //Check for boolean
        if(isLoggedIn == false) {
            
            //Message method when no field is filled
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Constants.ERROR_MESSAGE_1));
        }
    }

    /**
     * @Description  :  Generic method for creating Table for Current week.
     *
     * @args         :  
     *
     * @return       :  void
     *
    **/    
    public void tableOfEntry() {
    
        //assign false to boolean variable
        dt = Date.today();
        startOfWeek = dt.toStartOfWeek();
        
        //Loop Through no. of days in week
        for(Integer i = 1; i < 7 ; i++){
            Date dates = startOfWeek + i;
            
            //add into list of Time Tracking records list       
            companies.add(new Company__c(Task_Date__c = dates)); 
        }
    }
    
            
    /**
     * @Description  :  Method to update Time sheet table on selection of the "Project" with this weeks records and change the Content of table on change of project by user.
     *
     * @args         :  
     *
     * @return       :  void
     *
    **/    
    public void onSelectAction(){
        
        //Initiallize
        companiesList = new List<Company__c>(); 
        Map<Date, Company__c> companyWithDates = new Map<Date, Company__c>();

        //Check for String
        if(!String.isBlank(selectedProject)) {
            
             //Initiallize
            companies = new List<Company__c>();
            tableOfEntry();
        
        } else {
            
            //Initiallize list when nothing is selected
            companies = new List<Company__c>();
        }

        //Query on Company Records
        for(Company__c comp : [Select Id, Name, Task_Date__c, Hours__c, Status__c, Task_Detail__c, Project__c From Company__c Where Related_Developer_Client__c =: contactId AND CreatedDate >=: Date.today().toStartOfWeek()]) {
    
            //Populating map with this week records
            if(workStatusRecordsCreatedThisWeek.containsKey(comp.Project__c)) {
                 workStatusRecordsCreatedThisWeek.get(comp.Project__c).add(comp);
            } else {
                workStatusRecordsCreatedThisWeek.put(comp.Project__c, new List<Company__c>{comp});
            }
        }

        //Check for Null and map size
        if(selectedProject != '' && selectedProject != null && workStatusRecordsCreatedThisWeek.size() > 0) {
        
            //assign false to boolean variable
            dt = Date.today();
            startOfWeek = dt.toStartOfWeek();

            //Check for Map
            if(workStatusRecordsCreatedThisWeek.containsKey(selectedProject)) {
                
                //Loop according to Week Days
                for(integer i = 1; i<=6; i++) {
                    
                    //Loop through map Values
                    for(Company__c comp : workStatusRecordsCreatedThisWeek.get(selectedProject)) {
                        
                        //Populating Map
                        companyWithDates.put(comp.Task_Date__c, comp);

                        //Check if record of list's date value is equal to myDate variable
                        if(!companyWithDates.containsKey(startOfWeek + i)) {
                            
                            //Populating map with blank values
                            companyWithDates.put(startOfWeek + i, new Company__c(Task_Date__c = startOfWeek + i));
                        }
                    } 
                }
            }
    
            //Check for Size
            if(companyWithDates.size() > 0) {
                
                //Initiallize
                companies = new Company__c[6];
        
                //Loop through mao Values
                for(Company__c cmp : companyWithDates.values()) {
                    
                    if(cmp.Task_Date__c == startOfWeek + 1) {       
                        
                        //Add to list
                        companies.set(0, cmp);
                    } else if(cmp.Task_Date__c == startOfWeek + 2) {        
                        
                        //Add to list
                        companies.set(1, cmp);
                    } else if(cmp.Task_Date__c == startOfWeek + 3) {        
                        
                        //Add to list
                        companies.set(2, cmp);
                    } else if(cmp.Task_Date__c == startOfWeek + 4) {        
                        
                        //Add to list
                        companies.set(3, cmp);
                    } else if(cmp.Task_Date__c == startOfWeek + 5) {        
                        
                        //Add to list
                        companies.set(4, cmp);
                    } else if(cmp.Task_Date__c == startOfWeek + 6) {        
                        
                        //Add to list
                        companies.set(5, cmp);
                    }
                }
            }
        }
    }

    /**
     * @Description  :  helping method when user get logged in populating the Project select List.
     *
     * @args         :  String, String
     *
     * @return       :  
     *
    **/    
    public void populateProjectSelectlist(String contactId, String isClient) {

        //Check for Contact Id
        if(contactId != Null && contactId != '' && client == 'true' && isLoggedIn == true) {
            
            companiesList = new List<Company__c>(); 

            for(Contact contactName : [ Select Id, FirstName, LastName, Salutation From Contact Where Id =: contactId ]) {
                userName = contactName.Salutation + ' ' + contactName.FirstName + ' ' +contactName.LastName;
            }
        
            System.debug('###### ' + userName);

            //Query to the Records of the Project object
            for(Assigned_Project__c projects : [Select Id, Assigned_To__c, Project__r.Name From Assigned_Project__c Where Assigned_To__c =: contactId ORDER BY Project__r.Name ASC]) {
        
                //Add to options
                options.add(new SelectOption( projects.Project__r.Id, projects.Project__r.Name));
            }

        } else if(contactId != Null && contactId != '' && client == 'false' &&  isLoggedIn == true){

            for(Contact contactName : [ Select Id, FirstName, LastName, Salutation From Contact Where Id =: contactId ]) {
                userName = contactName.Salutation + ' ' + contactName.FirstName + ' ' +contactName.LastName;
            }
        
            System.debug('###### ' + userName);
        
            //Query to the Records of the Project object
            for(Assigned_Project__c projects : [Select Id, Assigned_To__c, Project__r.Name From Assigned_Project__c Where Assigned_To__c =: contactId ORDER BY Project__r.Name ASC ]) {
        
                //Add to options
                options.add(new SelectOption( projects.Project__r.Id, projects.Project__r.Name));
            } 
        }
    }

    /**
     * @Description  :  Method to update and insert record to company object according to there project and developer.
     *
     * @args         :  
     *
     * @return       :  PageReference
     *
    **/    
    public PageReference saveRecordsToCompany() {
        
        //List to hold Time Tracking records to be update and insert
        List<Company__c> pageRecordsToBeInsert = new List<Company__c>();
 
        System.debug('companies::::::::::::' + companies);

        //Check for selected Project
        if(selectedProject != Null && selectedProject != '') {
            
            //Loop through list of record on Page
            for(Company__c comp : companies){
                 
                //Check for name
                if(comp.Name != Null && comp.Name != '') {

                    //Query On Company
                    List<Company__c> alreadyExistingCompanies = [Select Id, Name, Task_Date__c, Hours__c, Status__c, Task_Detail__c, Project__c From Company__c Where Related_Developer_Client__c =: contactId AND CreatedDate >=: Date.today().toStartOfWeek() AND Project__c =: Id.valueOf(selectedProject) AND Task_Date__c =: comp.Task_Date__c ORDER BY Task_Date__c DESC];
       
                    //Check for Size
                    if(alreadyExistingCompanies.size() > 0) {
                        
                        //Loop through records
                        for(Company__c cmp :  alreadyExistingCompanies) {
                        
                            //New Instance 
                            Company__c company = new Company__c();
                            company.Id = cmp.Id;
                            company.Name = comp.Name;
                            company.Task_Date__c = comp.Task_Date__c;
                            company.Hours__c = comp.Hours__c;
                            company.Status__c = comp.Status__c ;
                            company.Task_Detail__c = comp.Task_Detail__c;
                            
                            //Add to list
                            pageRecordsToBeInsert.add(company);
                        }
                    } else {

                        //Instance of Time Tracking Object 
                        pageRecordsToBeInsert.add(new Company__c(Name = comp.Name, Task_Date__c = comp.Task_Date__c, Status__c = comp.Status__c, Hours__c = comp.Hours__c, Task_Detail__c = comp.Task_Detail__c, Project__c = Id.valueOf(selectedProject), Related_Developer_Client__c = contactId) );
                    }
                } 
            }
        } else {
        
            //Message method when no field is filled
         //   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Constants.ERROR_MESSAGE_6));
        }

        System.debug('pageRecordsToBeInsert:::::::::::::' + pageRecordsToBeInsert);
        
        //Check for size of list and upsert records
        if(pageRecordsToBeInsert.size() > 0) {
            upsert pageRecordsToBeInsert;
        }
        return null;
    }

    /**
     * @Description  :  Method used when Client is logged-in and fetching records according to the Client's projects.
     *
     * @args         :  
     *
     * @return       :  void
     *
    **/    
    public void showFilteredRecords() {
        
        //Initiallize
        Integer difference = 0; 
        companiesList = new List<Company__c>();
        
        //Assign values 
        date startDate = carrier.Start_Date__c;
        date lastDate = carrier.Final_Date__c;
        
        //Check for Null
        if(startDate != Null && lastDate != Null ) {
            difference = startDate.daysBetween(lastDate);
        }
        
        //Check for selected project
        if(selectedProject != Null && selectedProject != '') {

            //Query on Companies Records and looping
            for(Company__c comp : [ Select Id, Name, Hours__c, Status__c, Task_Date__c, Task_Detail__c, Project__c, CreatedDate From Company__c Where Project__r.Id =: selectedProject]) {
    
                //Check for options    
                if(startDate == Null && lastDate == Null) {  
                    
                    //Add to list
                    companiesList.add(comp);  
                
                //Check weather user have filled the date fields to filter records
                } else if(startDate != Null && lastDate != Null && difference != 0 ){  
                        
                    //Compare the created date with the filtering values
                    if( (date.ValueOf(comp.Task_Date__c) == lastDate || date.ValueOf(comp.Task_Date__c) < lastDate) && (date.ValueOf(comp.Task_Date__c) > startDate || date.ValueOf(comp.Task_Date__c) == startDate)) {
                    
                        //Add to list  
                        companiesList.add(comp);
                    }
                } else if (startDate != Null && lastDate != Null && difference == 0) {
                    
                    //Add records having start date 
                    if(date.ValueOf(comp.Task_Date__c) == startDate) {
                        //Add to list  
                        companiesList.add(comp);
                    }
                
                } else {
                     
                    //Message method when no field is filled
                    //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Constants.ERROR_MESSAGE_8));
                }
            }
        } else {
    
            //Message method when no field is filled
     //       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Constants.ERROR_MESSAGE_7 ));
        }
    }
    
    /**
     * @Description  :  Method is to download excel file of the records.
     *
     * @args         :  
     *
     * @return       :  pageReference
     *
    **/    
    public pageReference downloadExcelOfRecords() {

        //Page Url set
        PageReference newPage = New PageReference('/apex/TSSendExcelFileMonthly');

        //Reinitiallize all the atribute by this
        newPage.setRedirect(false);
                        
        //Return to page
        return newPage;     
    }
}