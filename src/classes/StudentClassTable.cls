/*
* Description   : This is class there to Display Student Class Name and No of Students.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/16/2012
*
* Version       : v1.0 - Create 
*/

//Class
public class StudentClassTable{

    //List of Class
    public List<AggregateResult> results {get; set;}
    public List<Class__c> listClass {get; set;}
    public Set<Id> setClass {get; set;}
    
    //Calling COnstructor
    public StudentClassTable() {
    
        listClass = [SELECT Id, Name FROM Class__c];
        
        //Loop
        for(Class__c cls : listClass) {
        
            //add
            setClass.add(cls.id);
        }
        
        //Query
        results = [SELECT Count(Name) cnt FROM Student__c WHERE Class__c In : setClass];
    }
}