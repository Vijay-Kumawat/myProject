/**
 *  Purpose         -   This scheduler is used for sending email to contacts for remainder of work status.
 *
 *  Created By      -  
 *
 *  Created Date    -   07/19/2013
 *
 *  Version         -   v1.0(Created)
 **/
global class Sched_WeeklyStatus implements Schedulable {
    
    //execute method 
    global void execute(SchedulableContext ctx) {
        
        //List of Contact records which have Email of simplyforce organization 
        List<Contact> contacts = [SELECT Id, FirstName, Email, IsClient__c FROM Contact WHERE Email Like '%.com' AND IsClient__c != TRUE];
        
        //get Email Template of DATA LOAD EMAIL TEMPLATE
        List<EmailTemplate> emailTemplates = [SELECT Id FROM EmailTemplate WHERE Name = 'TIME_SHEET_TEMPLATE' AND IsActive = true];
        
        //Initialize list of SingleEmailMessage
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();  
                    
        //Check for size of contacts list
        if(contacts.size() > 0) {
                
            //Loop through list of contacts
            for(Contact contact : contacts) {
                
                //Instantiates SingleEmailMessage
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                //set Target Object Ids
                mail.setTargetObjectId(contact.Id);
                
                //Set EmailTemplate 
                mail.setTemplateId(emailTemplates[0].Id);
                
                //Add mail in list
                mails.add(mail);
                system.debug('%%%%%%%%%'+mails);
            }
        }
        
        System.debug('###Size' + mails.size());
        
        //Check for mails list size
        if(mails.size() > 0)
            Messaging.sendEmail(mails);
    }
    
}