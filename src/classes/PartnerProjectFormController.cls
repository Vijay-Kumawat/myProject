/*
* Description   : This class is to get user information for partner project form.
* 
* Created By    : 
*
* Created Date  : 05/19/2013
*
* Version       : v1.0 - Created
*/

public class PartnerProjectFormController {

    //List to hold the values for Picklist fields
    public List<SelectOption> buildingPrimaryRadioList {get; set;}
    public List<SelectOption> buildingOwnershipRadioList {get; set;}
    public List<SelectOption> formStatusRadioList {get; set;}
    public List<SelectOption> energyEfficiencyCheckboxList {get; set;}
    public List<SelectOption> buildingPrimaryCheckboxList {get; set;}
    
    //List to hold selected checkboxes value
    public List<String> picklistValuesForBuildingPrimary {get; set;}
    public List<String> picklistValuesForEnergyEfficiency {get; set;}
    
    //Contact 
    public Contact contactRecord {get; set;}

    //Constructor Calling
    public PartnerProjectFormController(ApexPages.StandardController controller) {
    
        //Get record 
        contactRecord = (Contact)controller.getRecord();
    }
    
    //Method for the selection of Building size
    public List<SelectOption> getBuildingSize() {
    
        //Initialize the list for radio button
        buildingPrimaryRadioList = new List<SelectOption>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult status = Contact.Building_Size__c.getDescribe();
    
        //Get the picklist values
        List<Schema.PicklistEntry> picklistValue = status.getPicklistValues();
        
        //Fetch values from the picklist field
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select list with values
            buildingPrimaryRadioList.add(new SelectOption(str.getValue() , str.getValue())); 
        }
        //Return list
        return buildingPrimaryRadioList; 
    }
    
    //Method for the selection of Building Ownership
    public List<SelectOption> getBuildingOwnership() {
    
        //Initialize the list for radio buttons
        buildingOwnershipRadioList = new List<SelectOption>();

        //Describe the SOjbect
        Schema.DescribeFieldResult status = Contact.Building_Ownership__c.getDescribe();
    
        //Get the picklist values
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
    public List<SelectOption> getInformationForm() {
    
        //Initialize the list for radio buttons
        formStatusRadioList = new List<SelectOption>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult status = Contact.Form_Status__c.getDescribe();
    
        //Get the picklist values
        List<Schema.PicklistEntry> picklistValue = status.getPicklistValues();
        
        //Fetch values from the picklist field
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select list with values
            formStatusRadioList.add(new SelectOption(str.getValue() , str.getValue())); 
        }
        //Return list
        return formStatusRadioList; 
    }
    
    //Method for the selection of Energy Efficiency 
    public List<SelectOption> getEnergyEfficiency() {
    
        //Initialize the list
        picklistValuesForEnergyEfficiency = new List<String>();
    
        //Initialize the list for checkboxes
        energyEfficiencyCheckboxList = new List<SelectOption>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult status = Contact.Energy_Efficiency_Multi_Picklist__c.getDescribe();
    
        //Get the picklist values
        List<Schema.PicklistEntry> picklistValue = status.getPicklistValues();
        
        //fetch values from the picklist
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select list with values
            energyEfficiencyCheckboxList.add(new SelectOption(str.getValue() , str.getValue())); 
        }
        //Return list
        return energyEfficiencyCheckboxList; 
    }
    
    //Method for the selection of Building Primary Use
    public List<SelectOption> getBuildingPrimary() {
    
        //Initialize the list
        picklistValuesForBuildingPrimary = new List<String>();
    
        //Initialize the list for checkboxes
        buildingPrimaryCheckboxList = new List<SelectOption>();
    
        //Describe the SOjbect
        Schema.DescribeFieldResult fieldDescribe = Contact.Building_Primary_Multi_Picklist__c.getDescribe();
    
        //Get the picklist values
        List<Schema.PicklistEntry> picklistValue = fieldDescribe.getPicklistValues();
        
        //Fetch values from the picklist field
        for (Schema.PicklistEntry str : picklistValue) {
         
            //Populate the select options with values
            buildingPrimaryCheckboxList.add(new SelectOption(str.getValue() , str.getValue())); 
        }
        //Return list
        return buildingPrimaryCheckboxList; 
    }
    
    //Page reference Save Method
    public PageReference saveData() {
    
        //Page reference for the return page
        PageReference pageRef = new PageReference('https://c.ap1.visual.force.com/apex/Thank_You');
        
        //Loop throught the list for Energy Efficiency
        for(String str : picklistValuesForEnergyEfficiency) {
        
            //Check for the null values
            if(contactRecord.Energy_Efficiency_Multi_Picklist__c != null)
                contactRecord.Energy_Efficiency_Multi_Picklist__c += str + ';'; 
            else
                contactRecord.Energy_Efficiency_Multi_Picklist__c = str + ';';
        }
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