/**
  *     Description    :    Class that return records according to selected sobject.
  *
  *     Created By     :    Subhash Garhwal
  *
  *     Created Date   :    4/20/2013
  *
  *     Revision Log   :    V_1.0 Created.
  *
**/
//Class with global access modifier to access class by soap api 
global with sharing class SearchRecords {
    
    //Method with websevice keyword to expose this as a part of Web service.
    webservice static string searchRecordDetail(String objName) {
    	
        //Variable declaration & memory allocation
        String dataSource = '';

        //Check if objName equals to CustomObject
        if(objName.startsWith(Constants.QF_CUSTOM_OBJECT)) {
    
            //Call Web service callout to get custom object id and get reponse
            String responseString = HTTPRequestBuilder.getSObjectId(objName);
                    
            //Loop through response string
            for(String str : responseString.split('"attributes"')) {
                
                //Conditional statement for store search record seperated by "-"
                dataSource += '##' + String.valueOf(str.substringAfter('"Id":"').substringBefore('"')) + '-' + String.valueOf(str.substringAfter('"DeveloperName":"').substringBefore('"') + '-' + '');    
            }
        }
        //Check if objName equals to CustomField
        else if(objName.startsWith(Constants.QF_CUSTOM_FIELD)) {
        
            //Call Web service callout to get custom field id and get reponse
            String resString = HTTPRequestBuilder.getSObjectId(objName);
            
            //Loop through response string 
            for(String str : resString.split('"attributes"')) {
                
                //Retrieve custom object from response string
                String st = String.valueOf(str.substringAfter('"TableEnumOrId":"').substringBefore('"'));
                
                //Check if custom object contains id value or object name
                if(st.startsWith('0')) {
                
                    //Call Web service callout to get custom object id
            		String rS = HTTPRequestBuilder.getCustomObjectId(st);
                    
                    //Conditional statement for store search record seperated by "-"
                    dataSource += '##' + String.valueOf(str.substringAfter('"Id":"').substringBefore('"')) + '-' + String.valueOf(str.substringAfter('"DeveloperName":"').substringBefore('"')) + '-' + String.valueOf(rS.substringAfter('"DeveloperName":"').substringBefore('"')); 
                }
                else 
                    //Conditional statement for store search record seperated by "-"
                    dataSource += '##' + String.valueOf(str.substringAfter('"Id":"').substringBefore('"')) + '-' + String.valueOf(str.substringAfter('"DeveloperName":"').substringBefore('"')) + '-' + String.valueOf(str.substringAfter('"TableEnumOrId":"').substringBefore('"')); 
            }
        }
        else {
        	
            //Loop through field of sobject
            for(SObject sObj : database.query('Select Id, Name From ' + String.escapeSingleQuotes(objName))) {
                
                //Conditional statement for the store search record seperated by "-"
                if(dataSource == '')
                    dataSource = String.valueOf(sObj.get('Id')) + '-' + String.valueOf(sObj.get('Name') + '-' + '');
                else
                    dataSource += '##' + String.valueOf(sObj.get('Id')) + '-' + String.valueOf(sObj.get('Name') + '-' + ''); 
            }
        }
        
        //Returning search records
        return dataSource;
    }
}