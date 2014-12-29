/**Description :-- Creating a field whose value depends upon a picklist*/

 //Created date :-- 1/23/2013

 //Created By:-- Vijay Kumar Kumawat
 
 //Version :-- p1.0
 
 //Revision log:-- 1/23/2013

//defining class
public class PickListValue {

    //String 
    public string courseName {get; set;}
    
    //String 
    public string toBeDisplayInBox {get; set;}
    
    //List of options
    public List<SelectOption> options {get; set;}
    
    //Calling Constructor
    public PickListValue() {
    
       //Diclaring the List of options
        options = new List<SelectOption>();
        
        //Adding the values to the list
        options.add(new SelectOption('MCA','MCA'));
        options.add(new SelectOption('BCA','BCA'));
        options.add(new SelectOption('BBA','BBA'));
    }   
    
    //Method which return nothing
    public void selectedOptions() {
    
         //Values in 'courseName' will be same as 'toBeDisplayInBox'
        toBeDisplayInBox = courseName;
    
    }        
    
}