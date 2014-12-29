/*
*  Description  : This trigger is responsible for populate login user field
*
*  Created By   : Vijay Kumar Kumawat
*
*  Created Date : 10/08/2012
*
*  Version      : v1.0 - Create
*/

  trigger Trigger_Accuser on Account (before insert, before update) {

      //Current logged in Users List
      List <User> users = [SELECT Id, Name FROM User where Id =:UserInfo.getUserId()];
    
      //Loop for New Account Records
      for(Account acc : trigger.new) {
        
          //Populate Loogged in User field with Values
          acc.Logged_In_User__c = Users[0].Name;
          
          acc.GMT__c = string.valueOfGMT(acc.CreatedDate);
      }
        
  }