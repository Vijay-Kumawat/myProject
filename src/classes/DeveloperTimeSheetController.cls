/** 
  * Description     :   Developers Time sheet Controller Class
  *
  * Created By      :   
  *
  * Created Date    :   2/4/2014    
  *
  * Revision Log    :   V1.0      
  **/
public with sharing class DeveloperTimeSheetController {
    
    //Company
    public Company__c company { get; set; }
    public List<Company__c> companies { get; set; }
    public Date startOfWeek { get; set; }
    private Date dt;
    public String selectedProject { get; set; }
    
    //SelectOptions
    public List<SelectOption> options { get; set; }
    
    //Contructor
    public DeveloperTimeSheetController(ApexPages.StandardController controller) {
        
        //get record from standard controller
        company = (Company__c)controller.getRecord();
      
        //Initiallizing
        selectedProject  = '';
        companies = new List<Company__c>();
        options = new List<SelectOption>();
        options.add(new SelectOption('','Select one'));  
        
        //Query to the Records of the Project object
        for(Project__c projects : [Select Id, Name From Project__c]) {
        
            //Add to options
            options.add(new SelectOption( projects.Id, projects.Name));
        }
        
        //assign false to boolean variable
        dt = Date.today();
        startOfWeek = dt.toStartOfWeek();
        
        //Loop Through no. of days in week
        for(Integer i = 0; i < 7; i++){
            
            Date dates = startOfWeek + i;
            
            //add into list of Time Tracking records list       
            companies.add(new Company__c(Task_Date__c = dates)); 
        }
    }    
    
    //Method to save the records in salesforce Object
    public PageReference saveRecordsToCompany() {
        
        companies = new List<Company__c>();
        
          
        //Insert records
        insert companies;
        
        return null;
    }
}