public class MutiselectController {

public String getSelectedValue {get; set;}
public Contact contact {get; set;}

    public MutiselectController() {
    
        getSelectedValue = '';
        contact = new Contact();
    }
    
    //This method is to create a select option list for given Picklist Entries
    public static List<SelectOption> getSelectOptionListByField() {
        
        //Describe field and create a list of select options
        List<SelectOption> listOptions = new List<SelectOption>();
        
        //loop throough the picklist entries and populate select list
        for (Schema.PicklistEntry pE : Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap().get('Application_Status__c').getDescribe().getPickListValues()) {
         
            //Populate the select list with values
            listOptions.add(new SelectOption(pE.getValue() , pE.getLabel()));  
        }
        
        //Return list
        return listOptions;
    }
}