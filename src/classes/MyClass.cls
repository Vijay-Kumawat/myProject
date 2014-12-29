public class MyClass {

    //List of Student
    public List<Student__c> listStudent {get; set;}
    public List<Student__c> tempList {get; set;}
    public String stdName {get; set;}
    public Set<String> setString {get; set;}
    
    //Map 
    Map<String, List<Student__c>> mapStudents;
    
    //Map
    Map<String, Student__c> mapStudent;
    
    //Calling COnstructor
    public MyClass() {
        
        //Map Initial
        mapStudents = new Map<String, List<Student__c>>();
        
        //Map Initial
        mapStudent = new Map<String, Student__c>();
        
        //Populate List
        listStudent = [SELECT ID, Name, Email__c From Student__c];
        
        //Loop
        for(Student__c std : listStudent) {
        
            //Map Check
            mapStudent.put(std.Email__c, std);
             stdName = std.Email__c; 
        }
       
    }
    
    //Show
    public void show() {
        
       List<Student__c> lstStudent = new List<Student__c>();
              
        tempList = new List<Student__c>();
        setString = new Set<string>();
               
       //Loop
       for(Student__c student : listStudent) {
       
           //Check Map
           if(mapStudent.containsKey(student.Email__c) == false) {
               
               lstStudent = new List<Student__c>{student};
               
               //Populate
               mapStudents.put(student.Email__c, lstStudent);
           }
           else {
           
               lstStudent.add(student);
               mapStudents.put(student.Email__c, lstStudent);
           }
       }  
    
    for(Student__c stdss : listStudent) {
    
        if(stdss.Email__c != null) {
        
            setString.add(stdss.Email__c);
        }
    }
    
    for(Student__c stdsss : listStudent) {
        
        if(setString.contains(stdsss.Email__c)) {
            
            tempList.add(stdsss);
        }
    }
    }
}