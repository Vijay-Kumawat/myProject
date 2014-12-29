public class FlowControl {
        
    //---------------------------Contact Trigger Control--------------------------
    public static boolean runContactTrigger = true;
    
    //Return the run trigger boolean            
    public static boolean runContactTrigger(){
        return runContactTrigger;
    }
    
    //Set the run Trigger boolean
    public static void setRunContact(boolean value){
    
        if(value == true){
            runContactTrigger = true;
        }else{
            runContactTrigger = false;  
        }
    }
}