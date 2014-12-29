public class testingDatatable {
    
    public List<Company__c> acc { get; set; }

    public testingDatatable() {
    
        //Query
        acc = [Select Name, Task_Date__c From Company__c];
    }


}