/** 
  * Description     :   This is to send monthly records to the Admin.
  *
  * Created By      :   
  *
  * Created Date    :   2/12/2014    
  *
  * Revision Log    :   V1.0      
  **/
public with sharing class SendExcelFileMonthly {
    
    //List of Company
    public List<Company__c> companies { get; set; }
    
    //Constructor
    public SendExcelFileMonthly() {
        
        //Get first day and last day of Current month
        Date firstDayOfMonth = System.today().toStartOfMonth();
        Date lastDayOfMonth = firstDayOfMonth.addDays(Date.daysInMonth(firstDayOfMonth.year(), firstDayOfMonth.month()) - 1);   

        //Query of Company Records created this month
        companies = [Select Id, Name, Project__c, Status__c, Task_Date__c, Task_Detail__c, Task_Name__c, Hours__c, CreatedDate From Company__c 
                                             Where CreatedDate >=: System.today().toStartOfMonth()];
                                        
        System.debug('######' + companies);
        
     /*   //Email Attachments List
        List<Messaging.EmailFileAttachment> emailAttachments = new List<Messaging.EmailFileAttachment>();

        //Email Attachment for property invoice records csv
        Messaging.EmailFileAttachment emailCSVAttachment = new Messaging.EmailFileAttachment();
        emailCSVAttachment.setFileName('This Months');
        emailCSVAttachment.setBody(Blob.valueOf(dataRows));
    
        //Adding attachment record into the list
        emailAttachments.add(emailCSVAttachment);
    
        //Email Message Instahce
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        //Set attributes
        email.setSubject(subject);
        email.setPlainTextBody('Please find the attached Property Invoices CSV.');
        email.setFileAttachments(emailAttachments);
        email.setToAddresses(new List<String>{UserInfo.getUserEmail()});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
*/
    }  
}