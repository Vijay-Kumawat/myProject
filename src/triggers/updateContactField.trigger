trigger updateContactField on Contact (before Insert , before Update) {

    //Check for Request type
    if(Trigger.isBefore) {
    
        //Request for Event type 
        if(Trigger.isInsert || Trigger.isUpdate) {
        
            //Call Helper class method
            //ContactTriggerHelper.updateContactLookupField(Trigger.New , Trigger.oldMap , Trigger.isInsert);
            
            //Call Helper class method Modified with logic
            ContactTriggerHelper.updateContactLookupFieldNew(Trigger.New , Trigger.oldMap , Trigger.isInsert);
        }
    }
}