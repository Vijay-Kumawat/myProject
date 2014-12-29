public class GetAllFieldsFromSOjbect {

    //String to hold the user selection
    public String selectedSobejct {get; set;}
    
    //Select list of SObejct
    public List<SelectOption> parentSObjects {get; set;}
    
    //Select list of all fields
    public List<SelectOption> parentSObjectsFields {get; set;}
    
    //Getter Method
    public List<SelectOption> getParentsObejctNames() {
    
        //Memory Allocation
        parentSObjects = new List<SelectOption>();
        
        //Get All sObejct Schema
        Map<String, Schema.SObjectType> mapParentsObejcts = Schema.getGlobalDescribe();
        
        //List to hole the SObjects        
        List<Schema.SObjectType> parentsObejctsList = mapParentsObejcts.values();
        
        //Loop through sObejcts
        for(Schema.SObjectType parent : parentsObejctsList) {
        
            //Populate select list with options
            parentSObjects.add(new SelectOption(parent.getDescribe().getName(), parent.getDescribe().getLabel()));
        } 
        
        //Return Select List
        return parentSObjects;
    }    
    
    //Page reference Method
    public pageReference getTeamMembers() {
      
      getAllFieldsDisplay(); 
    
      return null; 
    
    }  
    
    //Method to display all the fields
    public List<SelectOption> getAllFieldsDisplay() {
    
        //Get All sObejct Schema
        Map<String, Schema.SObjectType> mapParentsObejcts = Schema.getGlobalDescribe();
        
        //Memory Allocation
        parentSObjectsFields = new List<SelectOption>();
        
        //Getting the SObject from the SObject Schema
        Schema.SObjectType s = mapParentsObejcts.get(selectedSobejct);
        
        //Describe the SOjbect Schema
        Schema.DescribeSObjectResult r = s.getDescribe();
        
        //Map to hold all the SObject Fields
        Map<String,Schema.SObjectField> fields = r.fields.getMap();
        
        //Loop to Populate the fields
        for (String fieldName: fields.keySet()) {
        
            //Populate the list with all the fields
            parentSObjectsFields.add(new SelectOption(fieldName, fieldName));  
        } 
        //Assert For Results
        System.debug('##### fields::' + parentSObjectsFields);
        
        //Return the list of fields
        return parentSObjectsFields;
   }     
}