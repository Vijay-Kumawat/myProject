/**
 *  Description     :   This class is there to merge duplicate Contact records.
 *
 *  Created Date    :   03-06-2014 
 * 
 *  Revision Logs   :   V_1.0 - Created
 *
**/  
global class Batch_MassDuplicateContactMerge implements Database.Batchable<sObject> {
	
    //String to hold the Contact object fields names
    String contactFieldsNamesString = '';
    
    //Set to hold the Contact fields API name strings
    Set<String> setContactFieldsNameString;
    
    //Set to hold the contact email with account id
    Set<String> setAccountIdWithEmail;
    
    //Calling Constructor
    global Batch_MassDuplicateContactMerge() {
        
        //Memory Allocation to collections
        setContactFieldsNameString = new Set<String>();
        setAccountIdWithEmail = new Set<String>();
        
        //Describe Contact object and get all the fields
        Map<String, Schema.SObjectField> contactFieldsMap = Contact.sObjectType.getDescribe().fields.getMap();
    
        //Loop through Contact fields Names through Schema Methods
        for(String fieldName : contactFieldsMap.keySet()) {
                
            //Describe field
            Schema.DescribeFieldResult field = contactFieldsMap.get(fieldName).getDescribe();
          
            //Filtering out the fields for getting only updatable non system fields
            if(!field.isCalculated() && field.isCreateable() && field.isUpdateable()) {
                
                //Populate set with the Fields Names string values
                setContactFieldsNameString.add(field.getLocalName());
                
                //Contact object fields name string
                if(contactFieldsNamesString == '')
                    contactFieldsNamesString = field.getLocalName(); 
                else
                    contactFieldsNamesString += ',' + field.getLocalName();
            }
        }
    }
    
    //Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        //Query for get contact reocrds
        String SOQLQuery = 'Select ' + contactFieldsNamesString +  ' FROM Contact WHERE Email != null AND AccountId != null';
        
        return Database.getQueryLocator(SOQLQuery);
    }  
    
    //Exectue Method
    global void execute(Database.BatchableContext BC, List<Contact> scope) {
    	
    	//Set to hold the account id with email strign
        Set<String> setAccountIdWithEmailStrings = new Set<String>();
        
        //Map to hold the Contact records corresponding the account id and email value as key
        Map<String, List<Contact>> mapAccountIdEmailKeyWithContacts = new Map<String, List<Contact>>();
        
        //This map is to hold the Parent Id and List of List of Contacts. One list will have maximum 2 child records.
        //Standard merge statement allows to merge 3 records at a time, so List of list will hold list of 2 child records
        Map<Id, List<List<Id>>> mapParentContactWithListOfChildrenContacts = new Map<Id, List<List<Id>>>();
        
        //This map is to hold the updated Parent data always
        Map<Id, Contact> mapParentContact = new Map<Id, Contact>();
        
        //Dynamic query for Parent Contact records
        for(Contact con : scope) {
            
            //Checking value in set
            if(!(setAccountIdWithEmail.contains(con.Email.trim().toLowerCase()))) {
         
                //Populate set with values
                setAccountIdWithEmail.add(con.Email.trim().toLowerCase());
                setAccountIdWithEmailStrings.add(con.Email.trim().toLowerCase());
            }
        }
              
        //Check set for size
        if(setAccountIdWithEmailStrings != null) {
        	
        	//Map to hold maximum Activity counter
        	Map<Id, Integer> mapIdWithMaxActivity = new  Map<Id, Integer>();
        	
        	//Map to hold account id with email and set of contact ids
        	Map<String, Set<Id>> mapAccountIdEmailKeyWithContactIds = new Map<String, Set<Id>>();
        	Map<String, Contact> mapAccountIdEmailKeyWithParentContactId = new Map<String, Contact>();
        	
        	//List to hold contact records
        	List<Contact> contacts = Database.query('SELECT ' + contactFieldsNamesString + ' FROM Contact WHERE Email IN : setAccountIdWithEmailStrings AND Email != null AND AccountId != null');
	        
        	//List to hold event records
        	List<Event> listEvents = [SELECT Id , WhoId FROM Event WHERE WhoId != null AND WhoId IN : contacts];

			//Set to hold contact ids
			Set<Id> setContactIds = new Set<Id>();
			
			//Integer to hold maximum event counter
			Integer maxEventCounter = 0;

			//Loop through event records
			for(Event eve : listEvents) {
				
				//Check if set contains contact id
				if(setContactIds.contains(eve.WhoId)) {
					
					maxEventCounter +=1;
					mapIdWithMaxActivity.put(eve.WhoId, maxEventCounter);
				}
				else {
					
					maxEventCounter = 1;
					setContactIds.add(eve.WhoId);
				}
				
				//populate the map
				mapIdWithMaxActivity.put(eve.WhoId, maxEventCounter);
			}
			
			//List to hold task events
			List<Task> listTasks = [SELECT Id , WhoId FROM Task WHERE WhoId != null AND WhoId IN : contacts];

			maxEventCounter = 0;
	
			//Loop through task records
			for(Task tsk : listTasks) {
				
				//Check if set contains contact id
				if(mapIdWithMaxActivity.containsKey(tsk.WhoId)) {
					
					//maxEventCounter +=1;
					mapIdWithMaxActivity.put(tsk.WhoId,(mapIdWithMaxActivity.get(tsk.WhoId)+1));
				}
				else {
					
					maxEventCounter = 1;
					mapIdWithMaxActivity.put(tsk.WhoId, maxEventCounter);
					//setContactIds.add(tsk.WhoId);
				}
			}
			
            //Loop through eligible contact records
            for(Contact contact : contacts) {
            
            	//Key String
		    	String keyString = '';
		    	String accountIdString = '';
		    	
		    	//Appending
	        	if(contact.AccountId != null)
	        		accountIdString = contact.AccountId; 
	    		else
	    			accountIdString += null;
	    			
    			//Formation of key string with the help of account id and email address string
	    		keyString = accountIdString + '-' + contact.Email.trim().toLowerCase();
	    		
	    		//Check for key value in map
	        	if(mapAccountIdEmailKeyWithContacts.containsKey(keyString)) {
	        		
					//Get the Values of the Map and add Id to it.
	          		mapAccountIdEmailKeyWithContacts.get(keyString).add(contact);
	          		mapAccountIdEmailKeyWithContactIds.get(keyString).add(contact.Id);
				
				} else {
					//Creat a new Set at values and add Id to it.
	          		mapAccountIdEmailKeyWithContacts.put(keyString, new List<Contact>{contact});
	          		mapAccountIdEmailKeyWithContactIds.put(keyString , new Set<Id>{contact.Id});  
	        	}
	        	
	        	//Loop through set of contact ids
	        	for(List<Contact> listContacts : mapAccountIdEmailKeyWithContacts.values()) {
	        		
	        		//Variable to hold counter
	        		Integer maxCounter = 0;
	        		Id parentContactId = null;
	        		
	        		//Loop through contact ids
	        		for(Contact con : listContacts) {
	        			
	        			//Check for null
	        			if(con.Id != null) {
	        				
		        			//Check for counter
		        			if(mapIdWithMaxActivity.get(con.Id) > maxCounter) {
		        				maxCounter = mapIdWithMaxActivity.get(con.Id);
		        				parentContactId = con.Id;
		        				
		        				if(!mapAccountIdEmailKeyWithParentContactId.containsKey(con.AccountId + '-' + con.Email.trim().toLowerCase())) {
		        					mapAccountIdEmailKeyWithParentContactId.put(con.AccountId + '-' + con.Email.trim().toLowerCase(), con);
		        				}
		        			}
		        			else if(!mapAccountIdEmailKeyWithParentContactId.containsKey(con.AccountId + '-' + con.Email.trim().toLowerCase())) {
		        					mapAccountIdEmailKeyWithParentContactId.put(con.AccountId + '-' + con.Email.trim().toLowerCase(), con);
		        			}
	        			}
	        		} 
	        	} 
	        		        	
	        	//Loop through map keys
	        	for(String key : mapAccountIdEmailKeyWithContacts.keySet()) {
	        		
	        		//Checking if we have more than one contact record in the list corresponding to the account id and email combined string key
	        		if(mapAccountIdEmailKeyWithContacts.get(key) != null && mapAccountIdEmailKeyWithContacts.get(key).size() >= 1) {
        			
        				if(mapAccountIdEmailKeyWithParentContactId.containsKey(key)) {
        					
		    				//Contact record having oldest created date stamped on it will become parent of other dup recods
		    				Contact parentContact = mapAccountIdEmailKeyWithParentContactId.get(key);
		    				
		    				//Set Parent in Map with latest Values
		                	mapParentContact.put(parentContact.Id, parentContact);
		                	
		                	//Add a default list
			                List<List<Id>> lstOfLst = new List<List<Id>>();
			                lstOfLst.add(new List<Id>());
			                mapParentContactWithListOfChildrenContacts.put(parentContact.Id, lstOfLst);
		                	
		                	//Lopp through the child records
		                	//Set all the null field in Parent with child data if child have not null value
		                	for(Integer i=0; i<mapAccountIdEmailKeyWithContacts.get(key).size(); i++) {
		                		
		                		//Dup Child Contact record
		                		Contact childContact = mapAccountIdEmailKeyWithContacts.get(key)[i];
		                		
		                		//Loop through set having Contact object fields API Name with it
			                    for(String contactFieldAPIName : setContactFieldsNameString) {
			                    	
			                    	//Checking for value in child with respect to Parent
			                        if(parentContact.get(contactFieldAPIName) == null && childContact.get(contactFieldAPIName) != null) {
			                        	
			                        	//Populating Instance with value
			                            parentContact.put(contactFieldAPIName, childContact.get(contactFieldAPIName));   
			                        }
			                    }
			                       
			                    //Put the latest innstance of Parent Contact in Map
		                    	mapParentContact.put(parentContact.Id, parentContact);
			                    
			                    //Get List from Marging Map
			                    List<List<Id>> mergingContacts = mapParentContactWithListOfChildrenContacts.get(parentContact.Id);
			                    
			                    //Chekcif list size has been reached to 2, add a new List and add contact in that
			                    if(mergingContacts[mergingContacts.size() - 1].size() == 2) {
			                        
			                        //Add a new List
			                        mergingContacts.add(new List<Id>()); 
			                    }
			                    
			                    //Add Child record in List
			                    mergingContacts[mergingContacts.size() - 1].add(childContact.Id);
			                    
			                    //Put this list back in original map
			                    mapParentContactWithListOfChildrenContacts.put(parentContact.Id, mergingContacts);
			            	}
        				}
	        		}
	        	}
            }
        }
                  
        //Start Merging Process
        for(Contact parentContact : mapParentContact.values()) {
        	
            //Get merging list and start merging process
            if(mapParentContactWithListOfChildrenContacts.containsKey(parentContact.Id)) {
            	            
                //Loop through the merging list
                for(List<Id> contacts : mapParentContactWithListOfChildrenContacts.get(parentContact.Id)) {
                	
            		//Set to hold merging contacts
            		Set<Id> setContacts = new Set<Id>();
            		
            		//populate the set with values
            		setContacts.addAll(contacts);
            		
            		//Check if set contains parent id
            		if(setContacts.contains(parentContact.Id)) {
            			
            			//Remove the parent from set
            			setContacts.remove(parentContact.Id);
            			
            			//Initialize the list
                		contacts = new List<Id>();
                		
                		//Add ids in the set
                		contacts.addAll(setContacts);
            		}
            		
            		//Check for size
            		if(contacts != null && contacts.size() > 0) {
            		
	                    //Merge statement for merging of the child records with respect to Parent Contact record
	                    merge parentContact contacts;
            		}
                }        
            }
        }   
    }
    
    //Finish Method
    global void finish(Database.BatchableContext BC) {
    }
}