//Class for illustrating Select List Uses
public class SelectListCon {
    
    //String to hold the Values
    public String stringValue {get; set;}
    public List<Selectoption> listoptions {get; set;}    
    public String myString {get; set;}
    public String myListString {get; set;}
    
    //Controller
    public SelectListCon () {
    
    listoptions = new List<SelectOption>(); 
    
    listOptions.add( new SelectOption('Red', 'Red'));
    listOptions.add( new SelectOption('Yellow','Yellow'));
    listOptions.add( new SelectOption('Green', 'Green'));
    listOptions.add( new SelectOption('Violet', 'Violet'));
    }
    
    public void cancel() {
    
        myString = myListString ;  
                   
    }
    
}