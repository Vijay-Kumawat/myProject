/*
*  Description  : Trigger to populate Child Object field with the Value of Parent Object.
*
*  Created By   : Vijay Kumar Kumawat
*
*  Created Date : 10/16/2012
*
*  Version      : v1.0 - Create
*/

trigger Trigger_Stu_Field on Student__c(before insert, before update) {

    //Set
    Set<Id> setClass = new Set<Id>();
    
    //Loop
    for(Student__c std : Trigger.New) {
    
        //Add
        setClass.add(std.Class__c);
    }
        
        //Map
        Map<Id, Class__c> mapClass = new Map<Id, Class__c>([SELECT Id, Name, Stability__c FROM Class__c WHERE ID IN : setClass]);
        
        //for
        for(Student__c student : Trigger.new) {
    
           Class__c cls = mapClass.get(student.Class__c);
           student.Stability__c = cls.Stability__c;
        }
}