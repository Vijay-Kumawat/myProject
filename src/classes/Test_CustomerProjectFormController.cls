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
 
/*
 * Purpose         :   Test class for CustomerProjectFormController
 *
 * Created Date    :   05/22/2013
 *
 * Revision Log    :   V1.0 - Created
 *
 * Coverage        :   97%
*/

@isTest
private class Test_CustomerProjectFormController {

    //Test method
    static testMethod void myUnitTest() {
    
        //Contact Insert
        Contact contact = new Contact();
                contact.FirstName = 'James';
                contact.LastName = 'Devis';
                contact.Email = 'james@gmail.com';
                contact.Phone = '123456';
                contact.Building_Primary_Multi_Picklist__c = 'Education;Healthcare;Government';
        
        //Test start from here
        Test.startTest();
        
        //Standard Controller 
        ApexPages.StandardController sc = new ApexPages.StandardController(contact);
        
        //Constructor Calling
        CustomerProjectFormController controller = new CustomerProjectFormController(sc);
        
        //Calling the getter method
        List<SelectOption> buildingSize = controller.getBuildingSize();
        List<SelectOption> buildingOwnership = controller.getBuildingOwnership();
        List<SelectOption> taxStatus = controller.getTaxStatus();
        List<SelectOption> buildingPicklistValues = controller.getBuildingPrimary();
        
        //Populate the list through controller
        controller.picklistValuesForBuildingPrimary.add('Education');
        
        //Calling Page Reference Method
        PageReference pageRef = controller.saveData();
        
        //Assert for results
        System.assert(pageRef != null);
        
        //Query to fetch contact record
        List<Contact> contactRecord = [SELECT ID , FirstName , LastName FROM Contact];
        
        //Assert for results
        System.assertEquals(contactRecord.size() , 1); 
        
        //Test stop here
        Test.stopTest();
    }
}