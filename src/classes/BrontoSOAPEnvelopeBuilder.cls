/**
 *  Description : This class works as an Envelope builder factory. All the soap envelope will be created here and passed to appropriate place.
 * 
 *  Revision Logs:  V1.0 - Created
 **/
public class BrontoSOAPEnvelopeBuilder {
	
	//Getting API Token with the help of Configuration Manager
	public static Configuration_Manager__c config = Constants.CONFIGURATION_MANAGER;

	//Method to create the Login Envelope
	public static String createLoginEnvelope() {
		
		//Login Envelope String
		String loginEnvelope = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v4="http://api.bronto.com/v4">'
   							   		+ '<soapenv:Header/>'
   									+ '<soapenv:Body>'
										+ '<v4:login>'
									    	+ '<apiToken>' + config.Bronto_API_Key__c + '</apiToken>'
									    + '</v4:login>'
   									+ '</soapenv:Body>'
								+ '</soapenv:Envelope>';
								
		//Return envelope
		return loginEnvelope;
	}
	
	//Method to create the updateContact Envelope
	public static String createContactUpdateEnvelope(String sessionId , ID ContactId) {
		
		//Instance of contact/Memory allocation    
    	Contact contact = new Contact();
    	
    	//Contact going to be update				   
    	List<Contact> contacts = [Select ID, FirstName, LastName, Email, Name, Delay_Stop_Contact__c , Application_Status__c 
    								From Contact WHERE Id =: contactId];

 		//Checking list for size
 		if(contacts.size() > 0) {
 			
 			//Populate instance with values
 			contact = contacts[0];
 		}
 		
 		//String to hold the envelope
 		String updateContactEnvelope;
 		
 		if(contact.Delay_Stop_Contact__c != null || contact.Application_Status__c != null) {
 		
			//Envelope String
			updateContactEnvelope = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v4="http://api.bronto.com/v4">'
									    	+ '<soapenv:Header>'
									        	+ '<v4:sessionHeader>'
									            	+ '<sessionId>' + sessionId + '</sessionId>'
									      		+ '</v4:sessionHeader>'
									   		+ '</soapenv:Header>'
   											+ '<soapenv:Body>'
  											+ '<v4:updateContacts>'
         											+ '<contacts>'
            											+ '<email>' + contact.Email + '</email>'
            											+ '<status>' + Constants.UNSUBSCRIBE + '</status>'
     												+ '</contacts>'
      											+ '</v4:updateContacts>'
   											+ '</soapenv:Body>'
										+ '</soapenv:Envelope>';
 		} else {
 			
 			//Envelope String
			updateContactEnvelope = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v4="http://api.bronto.com/v4">'
									    	+ '<soapenv:Header>'
									        	+ '<v4:sessionHeader>'
									            	+ '<sessionId>' + sessionId + '</sessionId>'
									      		+ '</v4:sessionHeader>'
									   		+ '</soapenv:Header>'
   											+ '<soapenv:Body>'
  											+ '<v4:updateContacts>'
         											+ '<contacts>'
            											+ '<email>' + contact.Email + '</email>'
     												+ '</contacts>'
      											+ '</v4:updateContacts>'
   											+ '</soapenv:Body>'
										+ '</soapenv:Envelope>';	
 		}
										
		//Return Envelope
		return updateContactEnvelope;
	}
	
	//Method to create the readContacts Envelope for getting listIds values associated with a contacts
	public static String createReadContactsEnvelope(String currentSessionId, String contactBrontoID) {
	
		String readContactsEvelope = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v4="http://api.bronto.com/v4">'
   									 	+ '<soapenv:Header>'
									    	+ '<v4:sessionHeader>'
									         	+ '<sessionId>' + currentSessionId + '</sessionId>'
									      	+ '</v4:sessionHeader>'
									    + '</soapenv:Header>'
									    + '<soapenv:Body>'
									       + '<v4:readContacts>'
									         + '<filter>'
									            + '<id>' + contactBrontoID + '</id>'
									         + '</filter>'
									         + '<includeLists>true</includeLists>'
									         + '<pageNumber>1</pageNumber>'
									      + '</v4:readContacts>'
									   + '</soapenv:Body>'
									+ '</soapenv:Envelope>';
		//return Value							
		return readContactsEvelope;
	}
	
	//Method to create the readContacts Envelope for getting listIds values associated with a contacts
	public static String createRemoveFromListEnvelope(String seessionId, List<String> listHavingListIds, Integer i, String contactBrontoId, ID contactID) {
		
		//Instance of contact/Memory allocation    
    	Contact contact = new Contact();
    	
    	//Contact going to be update				   
    	List<Contact> contacts = [Select ID, FirstName, LastName, Email, Name, Delay_Stop_Contact__c , Application_Status__c 
    								From Contact WHERE Id =: contactId];
    								
		//Checking list for size
 		if(contacts.size() > 0) {
 			
 			//Populate instance with values
 			contact = contacts[0];
 		}
    	
		String removeFromListEnvelope = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v4="http://api.bronto.com/v4">'
										+ '<soapenv:Header>'
											+ '<v4:sessionHeader>'
												+ '<sessionId>' + seessionId + '</sessionId>'
											+ '</v4:sessionHeader>'
										+ '</soapenv:Header>'
										+ '<soapenv:Body>'
											+ '<v4:removeFromList>'
												+ '<list>'
													+ '<id>' + listHavingListIds[i] + '</id>'
												+ '</list>'
												+ '<contacts>'
													+ '<id>' + contactBrontoId + '</id>'
													+ '<email>' + contact.Email + '</email>'
													+ '<listIds>' + listHavingListIds[i] + '</listIds>'
												+ '</contacts>'
											+ '</v4:removeFromList>'
										+ '</soapenv:Body>'
									 + '</soapenv:Envelope>';
		//Return Value
		return removeFromListEnvelope;
	}
	 
	//Check for Null and if yes, then return blank
    public static String parseNull(String value) {
    	
    	//Return blank if value is null
    	if(value == null)
    		return '';
		
		//return original value
		return value;
    }
}