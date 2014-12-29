/*
* Description   : This class is there for illustration of what is the importance of Id in salesforce
*                 salesforce to relate different sobjects and how can we use this in custom code.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/13/2012
*
* Version       : v1.0 - Create 
*/
// Class
public class StudentRecordClass{

    //Student
    Student__c student;
    
    //Variables
    public String name { get; set; }
    public String lastName{get;set;}
    public String attendence{get;set;}
    public String email{get;set;}
    public Decimal fee{get;set;}
    public String sex{get;set;}
    public String classId {get; set;}
    
    //Calling Method
    public void save(){
    
        //Memory Allocation
        student = new Student__c();
    
        //Check for Values
        if(name != null && name.trim().length() >0) {
            if(classId != null && classId.trim().length()>0) {
                if(email != null && email.trim().length() >0) {    
            
                    //Populate Student Fields with Value
                    student.name = name;
                    student.last_name__c = lastNAme;
                    student.address__c = email;
                    student.sex__c = sex;
                    student.class__c = classId;
                    student.fee__c = fee;
                }
            }
        }
        
        //Check For Student
        upsert student;
    }
}