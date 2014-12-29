/**
 *  Description     :   Batch class for Sending the reocrds to Admin monthly.
 * 
 *  Created By      :   Abhi Tripathi(Simplyforce Technology)
 *
 *  Created Date    :   04/04/2013
 *
 *  Version         :   v1.0 - Created  
**/
public with sharing class MonthlyTimeSheetUpdate{
    
    //List of Records
    public List<Company__c> companyList { get; set; }
    
    //List of records
    public List<Company__c> companies { get; set; }
    
    //Constructor
    public MonthlyTimeSheetUpdate() {
    
        //Limiting the records by created date of current month only
        companyList = [SELECT Id, Task_Date__c, Project__r.Name, Task_Detail__c, Status__c, Hours__c, CreatedDate  FROM Company__c WHERE CreatedDate >=: Date.today().toStartOfMonth() ORDER BY CreatedDate DESC];
    
        //Limiting the records by created date of current week only
        companies = [SELECT Id, Task_Date__c, Project__r.Name, Task_Detail__c, Status__c, Hours__c, CreatedDate  FROM Company__c WHERE CreatedDate >=: Date.today().toStartOfWeek() ORDER BY CreatedDate DESC];
    
    }
}