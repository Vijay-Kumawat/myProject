/*
* Description   : This is class there to Display Student Class Name and No of Students in that class.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/16/2012
*
* Version       : v1.0 - Create 
*/

//Class
public class StudentClassStuTable{

    //List of Class
    public List<Class__c> listClass {get; set;}

    //Calling COnstructor
    public StudentClassStuTable() {
    
        //Populate list
        listClass = [SELECT Id, Name , No_of_Student__c FROM Class__c];      
    }
}