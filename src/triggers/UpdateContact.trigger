trigger UpdateContact on Contact (after update) {

    //Loop through Contact
    for(Contact con : Trigger.New) {
    
        //Check for flag status
        //if(flowControl.runContactTrigger() == true){
    
            //Method Calling
            //ContactController.updateContactRecord(con.Id);
        //}
    }

}