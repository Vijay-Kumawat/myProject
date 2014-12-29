/**
 *	Description		:	Helper class for Trigger_Account
 *
 *	Created By		:	Vijay Kumawat
 *
 *	Created Date	:	06/13/2014
**/

public class AccountTriggerHelper {
	
	//This method is for create account team member records under
	public static void createAccountTeamMember(List<Account> newRecords , Map<Id, Account> mapOldRecords) {
	
		//Map to hold account id as a key and user 1 id as a value
		Map<Id, Id> mapAccountIdWithUser1Id = new Map<Id, Id>();
		
		//Map to hold account id as a key and user 2 id as a value
		Map<Id, Id> mapAccountIdWithUser2Id = new Map<Id, Id>();
		
		//Loop through account records
		for(Account account : newRecords) {
			
			//Check for null or value changed
			if((account.User_1__c != null || account.User_2__c != null) 
			   && (mapOldRecords == null 
			   || (account.User_1__c != mapOldRecords.get(account.User_1__c).User_1__c 
			   || account.User_2__c != mapOldRecords.get(account.User_2__c).User_2__c))) {
			
				//Check if user 1 id is not null
				if(account.User_1__c != null)
					mapAccountIdWithUser1Id.put(account.Id , account.User_1__c);
				if(account.User_1__c != null)
					mapAccountIdWithUser2Id.put(account.Id , account.User_2__c);
		   }
		}
		
		//Check for size
		if(mapAccountIdWithUser1Id.size() > 0) {
			
			//List to hold task records
			List<Task> tasks = new List<Task>();
			
			//Loop through keyset
			for(Id id : mapAccountIdWithUser1Id.keySet()) {
				
				//Task Instance
				Task tsk = new Task();
				
				tsk.Priority = 'High';
				tsk.WhatId = id;
				tsk.WhoId = mapAccountIdWithUser1Id.get(id);
				
				//Add in list
				tasks.add(tsk); 
			}
			
			//Insert list
			insert tasks;
		}
	}
}