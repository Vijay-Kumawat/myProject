/*
*  Description  : Trigger on Class Object to populate its field with  the Values of Students Names associated to it.
*
*  Created By   : Vijay Kumar Kumawat
*
*  Created Date : 10/16/2012
*
*  Version      : v1.0 - Create
*/

trigger Trigger_Class on Class__c (before update) {

    //Set
    Set<id> setId = new Set<Id>();
    
    //loop
    for(Class__c cls : Trigger.new) {
    
        //Populate
        setId.add(cls.Id);
        
    }
    
    //List
    List<Student__c> students = [SELECT ID, Name, Class__c FROM Student__c WHERE Class__c IN : setId];
    
    //Variables Declare
    Integer i;
    String myString;
    String myFinalString;
    
    //Loop
    for(Class__c clas : Trigger.New) {
    
        //Loop
        for(i =0; i< students.size(); i++) {
        
            //Populate
            myString += '-' + students[i].Name;
        }
       
         myFinalString = myString.remove('null-');
         
        //Populate
        clas.Class_With_Student__c = myFinalString;
        
    }      
}