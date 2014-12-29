public class MyStudentClass {

    //List to hold Student Records
    Public List<Student__c> listStudent {get; set;}
    
    //Calling Constructor
    public MyStudentClass() {
    
        //Populating list with records
        listStudent = [SELECT Id, Name, Attendence__c FROM Student__c];
        
    }
}