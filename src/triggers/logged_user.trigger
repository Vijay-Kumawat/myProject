trigger logged_user on Account (before insert,before update){
    //loop on new users
    for(Account acc : Trigger.New) {
       
       //logic create
      // acc.Logged_In_User__c = 10; 
    }
    
}