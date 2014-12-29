public class DataTableComponentController {

public String fieldName{get; set;}

    //List to hold fields
    public List<String> columnHeader{
        get {
            List<String> fields = new List<String>();
        
            fields = fieldName.split(',');
            return fields; 
        }
    }
    
    //List to hold fields
    public List<String> columnTableHeader{
        get {
            List<String> fields = new List<String>();
        
            //List to get columns value as a array.
            for(String str : fieldName.split(',')) {
                
                List<String> dotList = new List<string>();
                
                //Check for dots
                if(str.split('\\.').size() > 1) {
                   
                   dotList = str.split('\\.');
                   System.debug('#######' + dotList);
                   if(dotList[0].right(3) == '__r') {
                       String s = dotList[0].replace('__r' ,'__c');
                       fields.add(s);
                   }
                   else
                       fields.add(dotList[0] + 'Id');
               }                   
                else {
                    fields.add(str);
                }
            }
            System.debug('$$$$$$$' + fields);
            return fields; 
        }
    }
}