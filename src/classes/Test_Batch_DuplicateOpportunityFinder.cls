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
 * Description      :   This is a test class for Batch_DuplicateContactsFinder apex class.
 *
 * Created Date     :   06-04-2013 
 *
 * Created By       :   Vijay Kumawat
 *
 * Revisiion Logs   :   V1.0 - Created
 *
 * Coverage         :   100%
**/
@isTest(seeAllData = false)
private class Test_Batch_DuplicateOpportunityFinder {

    //Test Method
    static testMethod void myUnitTest() {
        
        //Account
        Account account = new Account(Name = 'Test Account');
        insert account;
        
        //Opportunity
        Opportunity opportunity = new Opportunity();
                    opportunity.Name = 'MyOpps';
                    opportunity.StageName = 'Value Proposition';
                    opportunity.AccountId = account.Id;
                    opportunity.CloseDate = Date.newInstance(2013 , 06, 04);
        
        //List to hold the opportunity records
        List<Opportunity> listOpportunity = new List<Opportunity>();
        
        //Adding record in list
        listOpportunity.add(opportunity);
        
        //Calling Constructor of Utiltiy class
        Utility controller = new Utility();
        
        //Adding duplicate opportunity records with populated Account
        listOpportunity.addAll(controller.insertDuplicateOpportunityWithAccount(79, account.ID));
        
        //Adding duplicate opportunity records without Account
        listOpportunity.addAll(controller.insertDuplicateOpportunityWithOutAccount(20));
        
        //Insert list of opportunities
        insert listOpportunity;
        
        //Assert for result
        System.assertEquals(100, listOpportunity.size());
        
        //Start test from here
        Test.startTest();
        
        //Execute Batch 
        Database.executeBatch(new Batch_DuplicateOpportunityFinder(), 200); 
        
        //Stop test here
        Test.stopTest();
        
        //Query for children
        listOpportunity = [SELECT ID, Parent__c FROM Opportunity WHERE Parent__c != null];
        
        //Assert for results
        System.assertEquals(79, listOpportunity.size());
   
    }
}