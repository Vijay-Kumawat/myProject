/*
* Description   : This is Scheduler class to send an email.
*
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 02/12/2013
*
* Version       : v1.0 - Create 
*/

//Class
global class ScheduleEmailSend implements Schedulable {

    //Execute Method for Scheduling
    global void execute(SchedulableContext SC){
    
        // Send an email to the person
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'vijaykumawat16@gmail.com', 'vijay.simplyforce@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Vijay Kumar Kumawat');
        mail.setSubject('Testing Going On......... ');
        mail.setPlainTextBody
        ('This class is for send an email...............');
   
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        
        ScheduleEmailSend  m = new ScheduleEmailSend();
        String sch = '0 10 * * * ?';
        system.schedule('Mail Send', sch, m); 
        
    }
}