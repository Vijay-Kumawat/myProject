/*
* Description   : This class is to get user information for general customer information page.
* 
* Created By    : 
*
* Created Date  : 05/20/2013
*
* Version       : v1.0 - Created 
*/

public class CustomerProjectFormController {

    //List to hold the values for picklist fields
    public List<SelectOption> totalFloorspaceRadioList {get; set;}
    public List<SelectOption> buildingOwnershipRadioList {get; set;}
    public List<SelectOption> taxStatusRadioList {get; set;}
    public List<SelectOption> buildingPrimaryCheckboxList {get; set;}
    
    //Contact
    public Contact contactRecord {get; set;}
    
    //List to hold selected checkbox values
    public List<String> picklistValuesForBuildingPrimary {get; set;}

    //Constructor Calling
    public CustomerProjectFormController(ApexPages.StandardController controller) {
    
        //Get record 
        contactRecord = (Contact)controller.getRecord();
    }
    
    //Method for the selection of Total floorspace
    public List<SelectOption> getBuildingSize() {
    
        //Initialize the list for radio button
        totalFloorspaceRadioList = new List<SelectOption>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult status = Contact.Total_Floorspace__c.getDescribe();
    
        //Get the picklist values from the field
        List<Schema.PicklistEntry> picklistValue = status.getPicklistValues();
        
        //Fetch values from the picklist field
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select list with values
            totalFloorspaceRadioList.add(new SelectOption(str.getValue() , str.getValue())); 
        }
        //Return list
        return totalFloorspaceRadioList; 
    }
    
    //Method for the selection of Building Ownership
    public List<SelectOption> getBuildingOwnership() {
    
        //Initialize the list for radio button
        buildingOwnershipRadioList = new List<SelectOption>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult status = Contact.Building_Ownership_GForm__c.getDescribe();
    
        //Get the picklist values from the field
        List<Schema.PicklistEntry> picklistValue = status.getPicklistValues();
        
        //Fetch values from the picklist field
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select list with values
            buildingOwnershipRadioList.add(new SelectOption(str.getValue() , str.getValue())); 
        }
        //Return list
        return buildingOwnershipRadioList; 
    }
    
    //Method for the selection of Already submitting the form
    public List<SelectOption> getTaxStatus() {
    
        //Initialize the list for radio button
        taxStatusRadioList = new List<SelectOption>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult status = Contact.Tax_Status__c.getDescribe();
    
        //Get the picklist values from the field
        List<Schema.PicklistEntry> picklistValue = status.getPicklistValues();
        
        //Fetch values from the picklist field
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select list with values
            taxStatusRadioList.add(new SelectOption(str.getValue() , str.getValue())); 
        }
        //Return list
        return taxStatusRadioList;  
    }
    
    //Method for the selection of Building Primary Use select checkbox
    public List<SelectOption> getBuildingPrimary() {
    
        //Initialize the list for checkboxes
        buildingPrimaryCheckboxList = new List<SelectOption>();
        
        //Initialize the list
        picklistValuesForBuildingPrimary = new List<String>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult fieldDescribe = Contact.Building_Primary_Multi_Picklist__c.getDescribe();
    
        //Get the picklist values from the field
        List<Schema.PicklistEntry> picklistValue = fieldDescribe.getPicklistValues();
        
        //Fetch values from the picklist field
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select list with values
            buildingPrimaryCheckboxList.add(new SelectOption(str.getValue() , str.getValue()));  
        }
        //Return list
        return buildingPrimaryCheckboxList; 
    }
    
    //Page reference Save Method
    public PageReference saveData() {
    
        //Page reference for the reutrn page
        PageReference pageRef = new PageReference('https://c.ap1.visual.force.com/apex/Thank_You');
       
        //Loop throught the list for Building Primary 
        for(String str : picklistValuesForBuildingPrimary) {
        
            //Check for the null values
            if(contactRecord.Building_Primary_Multi_Picklist__c != null)
                contactRecord.Building_Primary_Multi_Picklist__c += str + ';'; 
            else
                contactRecord.Building_Primary_Multi_Picklist__c = str + ';';
        }
        
        //Contact insert
        insert contactRecord;
    
        //Return page
        return pageRef;
    }
}