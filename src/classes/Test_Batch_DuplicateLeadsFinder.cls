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
 /**
 * Description      :   This is a test class for Batch_DuplicateLeadsFinder apex class.
 *
 * Created Date     :   06-04-2013 
 *
 * Created By       :   Vijay Kumar
 *
 * Revisiion Logs   :   V1.0 - Created
 *
 * Coverage         :   100%
**/
@isTest(seeAllData = false)
private class Test_Batch_DuplicateLeadsFinder {

    //Test Method
    static testMethod void myUnitTest() {
        
        //List to hold the Lead records
        List<Lead> listLeads = new List<Lead>();
        
        //Calling Constructor of Utiltiy class
        Utility controller = new Utility();
        
        //Adding duplicate Lead records with populated Email
        listLeads.addAll(controller.insertDuplicateLeadsWithEmail(80));
        
        //Adding duplicate Lead records with blank email
        listLeads.addAll(controller.insertDuplicateLeadsWithoutEmail(20));
        
        //Insert list of contacts
        insert listLeads;
        
        //Assert for result
        System.assertEquals(100, listLeads.size());
        
        //Start test from here
        Test.startTest();
        
        //Execute Batch 
        Database.executeBatch(new Batch_DuplicateLeadsFinder(), 200); 
        
        //Stop test here
        Test.stopTest();
        
        //Query for children
        listLeads = [SELECT ID, Parent__c FROM Lead WHERE Parent__c != null];
        
        //Assert for results
        System.assertEquals(79, listLeads.size());
    }
}