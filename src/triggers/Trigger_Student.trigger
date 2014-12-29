trigger Trigger_Student on Student__c (before insert, before update) {

    //Set
    Set<Id> setClass = new Set<Id>();
    
    //Loop
    for(Student__c std : Trigger.New) {
    
        //Add
        setClass.add(std.Class__c);
        
    }
    
    //Map
    Map<Id, Class__c> mapClass = new Map<Id, Class__c>([SELECT Id, Name, Class_with_Student__c FROM Class__c WHERE ID IN : setClass]);


    //for
    for(Student__c student : Trigger.new) {
    
       Class__c cls = mapClass.get(student.Class__c);
       
       cls.Class_with_Student__c = student.First_Name__C;
   } 
}