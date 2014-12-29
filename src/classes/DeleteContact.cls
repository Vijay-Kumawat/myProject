/*
* Description   : This is Batch class there to perform Delete Records form Contact .
*                 and Send a Email to the Owner.
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 11/08/2012
*
* Version       : v1.0 - Create 
*/

//Batch Class 
global class DeleteContact implements Database.Batchable<sObject>, Database.stateful { 
    
    //Variable
    public Integer SuccessCounter = 0;
    public Integer FailureCounter = 0;
    public Integer i;

    //Start Method to Collect Contact Record
    global Database.QueryLocator start(Database.BatchableContext BC) { 
    
        //Query for Contact Records
        return Database.getQueryLocator([SELECT ID FROM Contact]); 
    }   
    
    //Execute Method to Perform Operation
    global void execute(Database.BatchableContext BC,List<Contact> scope) { 
    
        //Delete the Records those are in Contexts
        Database.DeleteResult[] delresults = Database.delete((scope),false);
   
        //Loop
        for(Database.DeleteResult dr : delResults){
            
            //Conditional Statement
            if(!dr.isSuccess()){
                        
                Database.Error[] errs = dr.getErrors();
                
                //Loop on Errors List
                for(Database.Error err : errs) {
               
                    //Check
                    System.debug('$#$#$#$' + err.getStatusCode() + ' - ' + err.getMessage());
                    System.debug('ErrorMessage##########'+ err.getMessage());
                } 
                FailureCounter++;
                SuccessCounter = delresults.size()-FailureCounter;
            }
        }      
    }
    
    //Finish Method
    global void finish(Database.BatchableContext BC){
    
        // Get the ID of the AsyncApexJob representing this batch job
        // from Database.BatchableContext.
        // Query the AsyncApexJob object to retrieve the current job's information.
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
        TotalJobItems, CreatedBy.Email
        FROM AsyncApexJob WHERE Id =
        :BC.getJobId()];
        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'bhawani.sh.sharma@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Vijay Kumar Kumawat');
        mail.setSubject('Batch Process Completed ' + a.Status);
        mail.setPlainTextBody
        ('The batch Apex job processed ' + a.TotalJobItems +
        ' batches with '+ a.NumberOfErrors + ' failures.'+ 'Success Records ' +
          SuccessCounter + ' Failure Records ' + FailureCounter);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}