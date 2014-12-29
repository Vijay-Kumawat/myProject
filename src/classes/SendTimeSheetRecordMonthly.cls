/**
 *  Purpose         :    This scheduler is used for sending email to the user of monthly work status records.
 *
 *  Created By      :    Abhi Tripathi (Simplyforce)  
 *
 *  Created Date    :    04/05/2013
 *
 *  Version         :    v1.0(Created)
 **/
global class SendTimeSheetRecordMonthly implements Schedulable {
    
    //execute method 
    global void execute(SchedulableContext ctx) {
        
        //page having monthly records
        PageReference pr = New PageReference('/apex/MonthlyTimeSheetRecords');  
        
        //fetch records in pdf
        blob pdf = pr.getContentAsPDF();
        
        //For attachin a file
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        string csvname= 'Timesheet.csv';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(pdf);
        
        //Single email message
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        
        //Email Address
        String[] toAddresses = new list<string> {'bhawani.sh.sharma@gmail.com'};
        
        //Email Sbject
        String subject ='Monthly Time Sheet update';
        
        //Add the mail values in email
        email.setSubject(subject);
        email.setToAddresses( toAddresses );
        email.setPlainTextBody('Updated time sheet');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        
        //Sending email
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
}