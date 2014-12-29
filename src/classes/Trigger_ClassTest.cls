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
 
@isTest

//Test Class
private class Trigger_ClassTest {
/*
  Purpose      :   Test class for Trigger_Class
        
  Create By    :   Vijay Kumar Kumawat
  
  Created Date  :   10/16/2012
  
  Current Version  :   V1.0
  
  Revision Log  :  V1.0 - Created
            
  Coverage    :   100%
*/

    //Method
    private static testMethod void MyUnitTest(){
        
        //School
        School__c school = new School__c(Name = 'CPS');
        
        insert school;
        
        //Class
        Class__c clas = new Class__c(Name = '10' , School__c = school.Id);
        
        insert clas;
        
        //Student
        Student__c student = new Student__c(Name = 'Vijay' , Class__c = clas.Id , Address__c = 'ajmer');
        
        insert student;
        
        //Test Start form here
        Test.startTest();
        
            //Update
            update clas;
            
            //List of Student
            List<Student__c> listStudent = [SELECT Id, Name, Class__c From Student__c WHERE Class__c =: clas.Id];
            
            //List of Class
            List<Class__c> listClass = [SELECT Id, Name, Class_with_Student__c From Class__c];
            
            //Check for Results
            System.assertEquals(1, listStudent.size());
            System.assertEquals('Vijay', listStudent[0].Name);
            System.assertEquals(true, listClass[0].Class_With_Student__c == 'Vijay');
            System.assertEquals(true, clas.Class_With_Student__c == null);
       
        
        //Test Stop here
        Test.stopTest();
    }

}