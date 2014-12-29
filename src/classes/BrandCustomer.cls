/*
* Description   : This is Batch class there to perform Update the Brand Customer Records. 
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 11/10/2012
*
* Version       : v1.0 - Create 
*/

//Batch Class
global class BrandCustomer implements Database.Batchable<sObject>,Database.stateful {    
   
    //Start Method 
    global Database.QueryLocator start(Database.BatchableContext BC) { 
    
        //Query to Fetch Records
        return Database.getQueryLocator([SELECT ID, Phone__c, Email__c, Blank_Fields__c 
                                            FROM Brand_Customer__c 
                                            WHERE Email__c = Null OR Email__c = '' OR
                                            Phone__c = Null OR Phone__c = '']);
   
    }
    
    //Execute Method
    global void  execute(Database.BatchableContext BC, List<Brand_Customer__c> scope) {
        
        //List of Brand Cuostmer
        List<Brand_Customer__c> result = new List<Brand_Customer__c>();
        
        //For Loop
        for(Brand_Customer__c br : scope) {
        
            //Variable to hold the blank fields names
            String blankFields = '';
        
            //When Email is  null
            if(br.Email__c == NULL || br.Email__c == ''){
            
                blankFields += ' Email,';
            }
            
            //When Phone is  null
            if(br.Phone__c == NULL || br.Phone__c == '') {
            
                blankFields += ' Phone,';
            }
            
            //Trim value and than remove the additional commas
            blankFields = blankFields.trim();
            blankFields = blankFields.subString(0, blankFields.length()-1);
            
            //Populate List with Values
            br.Blank_Fields__c = blankFields;
            
            //Add the Records in New List
            result.add(br);
        }    
            
        //Update the Brand Customer Records 
        Database.SaveResult[] record = Database.update((result),false);
      
    }
    
    //Finish Method
    global void finish(Database.BatchableContext BC){
    }
}