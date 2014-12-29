/**
* Description : Controller class for page of Account History of Grade
*
* Created Date : 12/10/2013
*
* Created By : Abhi Tripathi
*
* Version : V1.0 
**/
global class CompanyRecordsWrapper implements Comparable{

public Company__c company {get; set;}
public List<Company__c> companies {get; set;}

    //Calling Constructor
    global CompanyRecordsWrapper (Company__c company , List<Company__c > companies ) {
        this.company = company ;
        this.companies = companies ; 
    }

    // Compare opportunities based on the opportunity amount.
    global Integer compareTo(Object compareTo) {

        // Cast argument to AccountHistoryWrapper
        CompanyRecordsWrapper cRW = (CompanyRecordsWrapper )compareTo;

        // The return value of 0 indicates that both elements are equal.
        Integer returnValue = 0;

        if ( cRW.company.Task_Date__c > cRW.company.Task_Date__c) { 
            
            // Set return value to a positive value.
            returnValue = 1;
            
        } else if ( cRW.company.Task_Date__c  < cRW.company.Task_Date__c) {
            
            // Set return value to a negative value. 
            returnValue = -1; 
        }

        return returnValue; 
    }
}