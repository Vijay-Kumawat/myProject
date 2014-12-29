/** 
 * Discription     :    This apex class will be used for List View Button which will create a PDF of selected fields.
 *
 * Created By      :    09/11/2013
 *
 * Created Date    :    Abhi Tripathi    
 *
 * Version         :    V1.0
 *
 * Revision Log    :    09/11/2013 Created
 **/
public with sharing class ListViewButtonCreatePDF {

  //List of Contact
  public List<Contact> contactList { get; set; }
      
  //standard controller
  private ApexPages.StandardSetController setController;
  
  //List of string
  public List<string> leftSelected { get; set; } 
  public List<String> fieldLabels { get; set; }
  public List<String> fieldAPINames { get; set; }
  public List<SelectOption> selectFields { get; set; }
  
  //Map of fields
  Map<String, String> mapForFieldLabel;
  
  //Defining StandardSetController in Constructor
  public ListViewButtonCreatePDF(ApexPages.StandardSetController setController) {      
    
    //Inintiallize
    leftselected = new List<String>();
    contactList = new List<Contact>();
    selectFields = new List<SelectOption>();
        String conId = '';
        mapForFieldLabel = new Map<String, string>();  
        
    //List of Ids
    List<String> ids = new List<String>();
    
    //Fetch Ids from URL
    conId = ApexPages.currentPage().getParameters().get('id'); 
    
    //Check for Id if URL dont have any Id
    if(conId != null && conId != '') {
    
      //Split string  of Ids
      for(String str : conId.split(',')) {
        ids.add(str);  
      }  
    }  
    
    //Query
    contactList = [Select Id From Contact Where Id =: ids];    
    System.debug('%%%%%% value of contactList' + contactList);
  
    //Paasing List of Contact from StandardSetController
    setController = new ApexPages.StandardSetController(contactList); 
    
    //Set selected records
    setController.setSelected(contactList);  
      
    //Get all the fields of the object
    for(Schema.SObjectField sObjectFields : Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap().values()) {
      
      //Get Described variable
          Schema.Describefieldresult fieldDescribedResult = sObjectFields.getDescribe();
          
          //Check for the fields are accessible or not
          if(fieldDescribedResult.isAccessible()) {
        
        //Map filling
        mapForFieldLabel.put(fieldDescribedResult.getName(), fieldDescribedResult.getLabel());
        selectFields.add(new SelectOption(fieldDescribedResult.getName(), fieldDescribedResult.getLabel()));    
          }
    }
    
    //sorting the list alphabetially   
    selectFields.sort(); 
  }
  
  public String label { get; set; }
  public String name { get; set; }

  //Method
  public void pdfGenerator() {
    
    //Initiallize
    fieldLabels = new List<String>();    
    fieldAPINames = new List<String>();
    String soql = '';  
    String val = '';
    label = '';
    name = '';
    
    //check for val
    if(leftselected != null && leftselected.size() > 0) {
          
      //Loop
      for(String str : leftselected) {
        
        //List of labels of fields 
        if(mapForFieldLabel.containsKey(str)) {
          fieldLabels.add(mapForFieldLabel.get(str)); 
        }
        
        //List of api names
        fieldAPINames.add(str);  
        
        //Add to string of Api names
        val += str + ',';
      }
    
      //Check if string endswith ', '
      if(val.endsWith(',')) {
        
        //remove ending ','  
        val = val.removeEnd(','); 
      }
    }
    
    //Loop
    for(String label : fieldLabels) {
      label += label;
    }
    
    //Loop
    for(String str : fieldAPINames) {
      name += str;
    }
  
    //Check value of val
    if(val != null && val != '') {  
    
      //Query on database
      soql = 'Select ' + val + ' From Contact Where Id =:  contactList';
    
      //Fetching data  
      contactList = Database.query(soql);
      
    }else {
    
      //Error message
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Select Atleast One Field To Proceed'));
    }
  }

  //Method  
  public PageReference getShowPdf() {
       
    //Check for contactList  
    if(contactList != null && contactList.size() != 0) {
    
      //Creating Url for the new Window
      PageReference newPage = New PageReference('/apex/CreatePDFDynaminTable'); 
      newPage.getParameters().put('id', ApexPages.currentPage().getParameters().get('id')); 
      newPage.getParameters().put('label', label);
      newPage.getParameters().put('name', name);
      return newPage;       
    }        
    return null;
  }
}