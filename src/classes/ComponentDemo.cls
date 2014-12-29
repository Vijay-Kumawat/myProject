/**
  * Description     :   Controller for Datable Component.   
  *
  * Created By      :   Abhi Tripathi
  *
  * Created Date    :   12/27/2013
  *
  * Version         :   V1.0  
  *
  **/ 
public with sharing class ComponentDemo {
      
    //String
    public String columnHeader { get; set; }
    public String ObjectAPIName { get; set; }
    list<Schema.Sobjectfield> sObjectFieldsList;
    
    //List
    public List<String> fieldLabel{
        get {
            return columnTitle(); 
        }
    }
    
    //List retruning headers  
    public List<String> tabelHeader{
        get { 
            return dynamicTableHeaders(); 
        }
    }
     
    //List string   
    public List<String> columnTitle() { 
        
        //String declaration & memory allocation 
        List<String> selectedColumnTitle  = new List<String>();
        List<String> selectedWithDotColumnTitle  = new List<String>();
        
        //List to get columns value as a array.
        selectedColumnTitle = columnHeader.split(',');
        
        return selectedColumnTitle; 
    }
    
    //Processing of list of headers according to name of the field queried
    public List<String> dynamicTableHeaders() {
      
      //String declaration & memory allocation 
        List<String> ColumnDotTitle  = new List<String>();
        List<String> headers  = new List<String>();
        
        //Loop thorugh list of header provided by developer  
        for(String str : columnHeader.split(',')) {
          
          if(str.split('\\.').size() > 1) {
              if(str.split('\\.')[0].endsWith('__r')) {
                  str.split('\\.')[0].replace('__r','__c');
              } else {
                  str = str.split('\\.')[0] + 'Id';
              }
          }
          
          System.debug('ObjectAPIName:::::' + ObjectAPIName);
          
          //Get all the fields of Selected object
          sObjectFieldsList = Schema.getGlobalDescribe().get(ObjectAPIName).getDescribe().fields.getMap().values();
      
          //Loop through field set
          for(Schema.Sobjectfield schemaField : sObjectFieldsList ) {
              Schema.Describefieldresult FieldResult = schemaField.getDescribe();
        
        //Check for API name
        if(str == FieldResult.getName()) {
          //Add to list according to the javascript array format
              headers.add( '"' + FieldResult.getLabel() + '"');
        }
      }
        }
        return headers;
    }
}