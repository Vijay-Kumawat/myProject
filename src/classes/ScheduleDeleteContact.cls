/*
* Description   : This is class there to perform Schedule the Batch Class DeleteContact.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/09/2012
*
* Version       : v1.0 - Create 
*/

//Class
global class ScheduleDeleteContact implements Schedulable {

    //Execute Method for Scheduling
    global void execute(SchedulableContext SC){
    
        //Batch Class
        DeleteContact dc = new DeleteContact();
        Database.executeBatch(dc);
    }
}