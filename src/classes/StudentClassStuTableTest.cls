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
public class StudentClassStuTableTest {
/*
  Purpose      :   Test class for StudentClassStuTable
        
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
        insert  school;
    
        //Class
        Class__c clas = new Class__c(Name = '10' , School__c = school.Id);
        insert clas;
        
        //Student 1
        Student__c student1 = new Student__c(Name = 'Vijay' , Class__c = clas.Id , Address__c = 'Jaipur');
        insert student1;

        //Student 2
        Student__c student2 = new Student__c(Name = 'Ajay' , Class__c = clas.Id , Address__c = 'Bangal');
        insert student2;
        
        //Student 3
        Student__c student3 = new Student__c(Name = 'Nikhil' , Class__c = clas.Id , Address__c = 'Udaipur');
        insert student3;
        
        //Student 4
        Student__c student4 = new Student__c(Name = 'Raju' , Class__c = clas.Id , Address__c = 'Jodhpur');
        insert student4;
               
        //Test Start From Here
        Test.startTest();
       
            //Calling Constructor
            StudentClassStuTable controller = new StudentClassStuTable();
                
                //Checking
                System.assertEquals(4, controller.listClass[0].No_of_Student__c);
                         
        //Test Stop Here
        Test.stopTest();
    }
}