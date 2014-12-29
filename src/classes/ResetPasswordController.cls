/** 
  * Description     :   Reset password for Time sheet.
  *
  * Created By      :   Abhi Tripathi (Simplyforce Technology)
  *                
  * Created Date    :   2/21/2014    
  *
  * Revision Log    :   V1.0
  **/
public without sharing class ResetPasswordController {
    
    //Public variables
    public string emailId { get; set; }
    public string currentPassword { get; set; }
    public string newPassword { get; set; }
    public string newPassword2 { get; set; }
    
    //Constructor
    public ResetPasswordController() {
    
        //Initiallizing
        emailId = '';
        currentPassword = '';
        newPassword = '';
        newPassword2 = '';
    } 
    
    /**
     * @Description  :  Method to reset the password.
     *
     * @args         :  
     *
     * @return       :  
     *
    **/    
    public void passwordReset() {
    
        //Get contact password of the email entered by the user
        if(emailId != Null && emailId != '' && currentPassword != Null && currentPassword != '' && newPassword != Null && newPassword != '' && newPassword2 != Null && newPassword2 != '' ) {

            //Query on Contact
            List<Contact> contact = [Select Id, Email, Password__c From Contact Where Email =: emailId LIMIT 1];

            //Check for size
            if(contact.size() > 0) {
                
                //Check for current password
                if(contact[0].Password__c.compareTo(currentPassword) == 0) {

                    if(newPassword.length() >= 8) {

                        //Check for both new passwords are matching or not
                        if(newPassword.compareTo(newPassword2) == 0) {
                        
                            //updating contact with new password
                            Contact con = new Contact(Id = contact[0].Id, Password__c = newPassword);
                            update con;

                            //Message method when no field is filled
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, Constants.ERROR_MESSAGE_9 ));

                        } else {
                        
                            //Message method when no field is filled
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, Constants.ERROR_MESSAGE_10 ));
                        }
                    } else {
                        //Message method when no field is filled
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, Constants.ERROR_MESSAGE_11 ));
                    }
                } else {

                    //Message method when no field is filled
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, Constants.ERROR_MESSAGE_12 ));
                }
            } else {

                //Message method when no field is filled
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, Constants.ERROR_MESSAGE_13 ));
            }
        } else {
            //Message method when no field is filled
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, Constants.ERROR_MESSAGE_14 ));  
        }
    } 
}