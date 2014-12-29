/*
* Description   : This class is responsible for illustration of how to use different methods in 
*                 controller
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/13/2012
*
* Version       : v1.0 - Create 
*/

//Class
public class ShowDate {

    //Declare a Variable
    public Date date1{get;set;}
    public Date date2 {get ; set;}
    public Integer day {get ; set;}
    public Integer month {get ; set;}
    public Integer year {get ; set;}
    
    //String
    public String date3 {get ; set;}
    
    //Variable to Hold Data Time Type Values
    public DateTime dateTimeValue {get; set;} 
    
     //Constructor Calling    
     public ShowDate(){
         date1 = Date.today();
         day = Date.today().day();
         month = Date.today().month();
         year = Date.today().year();
         
         date3 = year + '/' + month + '/' + day;
         
         
         
         //Populate Date Time Variable
         dateTimeValue = System.now();
     }
}