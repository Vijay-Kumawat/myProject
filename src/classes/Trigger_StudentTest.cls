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
private class Trigger_StudentTest {
/*
  Purpose      :   Test class for Trigger_Student_Field
        
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
        Class__c clas = new Class__c(Name = '10' , School__c = school.Id , Stability__c = 'NO');
        
        insert clas;
        
        //Student
        Student__c student = new Student__c(Name = 'Vijay' , Class__c = clas.Id , Address__c = 'ajmer');
        
        insert student;
        
        //Test Start form here
        Test.startTest();
        
            //List of Class
            List<Student__c> std = [SELECT Id, Name, Class__c , Stability__c FROM Student__c WHERE Class__c =:clas.Id];
            
            //List of class
            List<Class__c> cls = [SELECT Id, Name, Stability__c FROM Class__c];
            
            
            //Check for Results
            System.assertEquals(true, std[0].Stability__c == cls[0].Stability__c);
                
        //Test Stop here
        Test.stopTest();
    }
    
    //Method
    private static testMethod void MyUnitTest1(){
        
        //School
        School__c school = new School__c(Name = 'CPS');
        
        insert school;
        
        //Class
        Class__c clas = new Class__c(Name = '10' , School__c = school.Id , Stability__c = 'NO');
        
        insert clas;
        
        //Student
        Student__c student = new Student__c(Name = 'Vijay' , Class__c = clas.Id , Address__c = 'ajmer');
        
        insert student;
        
        //Test Start form here
        Test.startTest();
        
        //Update 
        clas.Stability__C = 'YES';
        update clas;
        
        //Update 
        update student;
        
            //List of Class
            List<Student__c> std = [SELECT Id, Name, Class__c , Stability__c FROM Student__c WHERE Class__c =:clas.Id];
            
            //List of Class
            List<Class__c> cls = [SELECT Id, Name, Stability__c FROM Class__c];
            
            
            //Check for Results
            System.assertEquals(true, std[0].Stability__c == cls[0].Stability__c);
            System.assertEquals('YES', std[0].Stability__c);    
        //Test Stop here
        Test.stopTest();
    }
}