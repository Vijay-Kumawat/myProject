/*
* Description   : This is email service class for creating task associated with the contact.
* 
* Created By    : 
*
* Created Date  : 09/07/2013
*
* Version       : V_1.0 - Created 
*/

global class EmailServiceExample implements Messaging.Inboundemailhandler {

	//Method
	global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env){
		
		//Create instance of result class returing the stataus 
		Messaging.Inboundemailresult result = new Messaging.Inboundemailresult();
		
		//Query to get contact record from database with the basis of email address of sender's email.
		//If more than one record with the same email address than catch block will catch the error 
		try {
			
			//Query to get contact record
			Contact contact = [SELECT Id, Name, Email FROM Contact WHERE Email =: email.fromAddress];
			
			Task[] tsk = new Task[0];
			
			//populate the list with values
			tsk.add(new Task(Description = email.plainTextBody , 
									Status = 'Inbound Email' , Subject = email.Subject , 
									WhoId = contact.Id));
			
			//Insert task
			insert tsk;
			
			//Add the success in the result class
			result.success = true;
				
		} catch(QueryException e) {
			
			//Debug
			System.debug('Error Message' + e);
		}
		
		//return result
		return result;
	}
}