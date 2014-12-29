/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seeAllData=false)
private class Test_ResetPasswordController {
    
/** 
  * Description     :   Unit test method for reset controller of the Time sheet.
  *
  * Created By      :   Abhi Tripathi (Simplyforce Technology)
  *                
  * Created Date    :   2/4/2014    
  *
  * Revision Log    :   V1.0
  **/
    static testMethod void myUnitTest() {
        
        //Insert record of Contact
        Contact contact = new Contact(FirstName = 'Tead', LastName = 'Mosby', Email = 'test@testing.com', Password__c = 'sf#12345');
        insert contact;
        
        //Test starts here
        Test.startTest();
        
        //Calling controller
        ResetPasswordController controller = new ResetPasswordController();
        
        //Assigning values
        controller.emailId = '';
        controller.currentPassword = '';
        controller.newPassword = '';
        controller.newPassword2 = ''; 
        
        //Calling method
        controller.passwordReset();
        
        //Assert
        System.assert(ApexPages.getMessages()[0].getDetail().contains( 'All values need to be entered.' ));
        
        //Assigning values
        controller.emailId = 'test@test.com';
        controller.currentPassword = 'sf#12345';
        controller.newPassword = 'as@12345';
        controller.newPassword2 = 'as@12345'; 
        
        //Calling method
        controller.passwordReset();
        
        //Assert
        System.assert(ApexPages.getMessages()[1].getDetail().contains( 'Email does not Exist.' ));
        
        //Assigning values
        controller.emailId = 'test@testing.com';
        controller.currentPassword = 'sf#123';
        controller.newPassword = 'as@12345';
        controller.newPassword2 = 'as@12345'; 
        
        //Calling method
        controller.passwordReset();
        
        //Assert
        System.assert(ApexPages.getMessages()[2].getDetail().contains( 'Current Password is not correct.' ));
        
        //Assigning values
        controller.emailId = 'test@testing.com';
        controller.currentPassword = 'sf#12345';
        controller.newPassword = 'as@123';
        controller.newPassword2 = 'as@123'; 
        
        //Calling method
        controller.passwordReset();
        
        //Assert
        System.assert(ApexPages.getMessages()[3].getDetail().contains( 'Password must have 8 characters.' ));
        
        //Assigning values
        controller.emailId = 'test@testing.com';
        controller.currentPassword = 'sf#12345';
        controller.newPassword = 'as@12345';
        controller.newPassword2 = 'as@123456'; 
        
        //Calling method
        controller.passwordReset();
        
        //Assert
        System.assert(ApexPages.getMessages()[4].getDetail().contains( 'New password entered are not Matching.' ));
        
        //Assigning values
        controller.emailId = 'test@testing.com';
        controller.currentPassword = 'sf#12345';
        controller.newPassword = 'as@12345';
        controller.newPassword2 = 'as@12345'; 
        
        //Calling method
        controller.passwordReset();
        
        //Assert
        System.assert(ApexPages.getMessages()[5].getDetail().contains( 'Your password have been reset.' ));
        
        //Test stops here
        Test.stopTest();
    }
}