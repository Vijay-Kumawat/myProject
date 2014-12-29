public class classStudent{

    List<Student__c> listStudent;
    public List<StudentWrapper> listStudentWrapper {get;set;}
    public Map<Id, Integer> countMap {get;set;}

public classStudent(){
        
    listStudent = [SELECT Id, Class__c, Class__r.Name, First_Name__c FROM Student__c];
    countMap = new Map<Id, Integer>();
        
            for(Student__c stu : listStudent){
            Integer cnt = countMap.get(stu.Class__c);
                if(cnt == null){
                cnt = 0;
                }
                else{
                cnt++;            
                }
                countMap.put(stu.Class__c, cnt);           
             }
          
        listStudentWrapper = new List<StudentWrapper>();

        if(countMap.keySet().size() > 0){
            for(Student__c std : listStudent) {
            
            for(Id classId : countMap.keySet()){               
                 
                 listStudentWrapper.add(new StudentWrapper(std.Class__c, countMap.get(classId)));
            }
            }
        }
    }
    
     public class StudentWrapper {
        public String className {get;set;}
        public Integer totalStudents {get;set;}

    public StudentWrapper(String className, Integer totalStudents) {
    
        this.totalStudents = totalStudents;
        this.className = className;
    }
    }
}