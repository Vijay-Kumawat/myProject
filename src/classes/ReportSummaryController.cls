/**
 *  Description     :   This class is for displaying object records in page.
 * 
 *  Created By      :   Vijay Kumawat
 * 
 *  Created Date    :   03/31/2014
 * 
 *  Revision Logs   :   V_1.0 - Created
 *       
 **/  

public with sharing class ReportSummaryController {

	//Select options
	public List<SelectOption> caseFields {get; set;}
	public List<SelectOption> expertFields {get; set;}
	public List<SelectOption> programFields {get; set;}
	public List<SelectOption> caseCategoryFields {get; set;} 
	
	//Properties
	public String selectedCaseOperator {get; set;}
	public String selectedExpertOperator {get; set;}
	public String selectedProgramOperator {get; set;}
	public String selectedCaseCategoryOperator {get; set;}
	
	//Selected Fields
	public String selectedCaseField {get; set;}
	public String selectedExpertField {get; set;}
	public String selectedProgramField {get; set;}
	public String selectedCaseCategoryField {get; set;}
	
	//Selected Field Value
	public String selectedCaseFieldValue {get; set;}
	public String selectedExpertFieldValue {get; set;}
	public String selectedProgramFieldValue {get; set;}
	public String selectedCaseCategoryFieldValue {get; set;}
	
	//Maps
	public Map<String,String> mapCaseFields {get; set;}
	public Map<String,String> mapExpertFields {get; set;}
	public Map<String,String> mapProgramFields {get; set;}
	public Map<String,String> mapCaseCategoryFields {get; set;}
	
	//String to hold key prefix
	public String keyPrefixForCase {get; set;}
	public String keyPrefixForExpert {get; set;}
	public String keyPrefixForProgram {get; set;}
	public String keyPrefixForCaseCategory {get; set;}
	
	//Select Options List
	public List<SelectOption> casePicklistValues {get; set;}
	public List<SelectOption> expertPicklistValues {get; set;}
	public List<SelectOption> programPicklistValues {get; set;}
	public List<SelectOption> caseCategoryPicklistValues {get; set;}
	
	//Multi Select Picklist values
	public List<SelectOption> caseMultiSelectPicklistValues {get; set;}
	public List<SelectOption> expertMultiSelectPicklistValues {get; set;}
	public List<SelectOption> programMultiSelectPicklistValues {get; set;}
	public List<SelectOption> caseCategoryMultiSelectPicklistValues {get; set;}
	
	//List to hold case records
	public List<Case> cases {get; set;}
	
	//Constructor
	public ReportSummaryController() {
		
		//Initialization
		caseFields = new List<SelectOption>();
		expertFields = new List<SelectOption>();
		programFields = new List<SelectOption>();
		caseCategoryFields = new List<SelectOption>();
		selectedCaseOperator = '';
		selectedExpertOperator = '';
		selectedProgramOperator = '';
		selectedCaseCategoryOperator = '';
		selectedCaseField = '';
		selectedExpertField = '';
		selectedProgramField = '';
		selectedCaseCategoryField = '';
		selectedCaseFieldValue = '';
		selectedExpertFieldValue = '';
		selectedProgramFieldValue = '';
		selectedCaseCategoryFieldValue = '';
		keyPrefixForCase = '';
		keyPrefixForExpert = '';
		keyPrefixForProgram = '';
		keyPrefixForCaseCategory = '';
		casePicklistValues = new List<SelectOption>();
		expertPicklistValues = new List<SelectOption>();
		programPicklistValues = new List<SelectOption>();
		caseCategoryPicklistValues = new List<SelectOption>();
		expertMultiSelectPicklistValues = new List<SelectOption>();
		programMultiSelectPicklistValues = new List<SelectOption>();
		caseMultiSelectPicklistValues = new List<SelectOption>();
		caseCategoryMultiSelectPicklistValues = new List<SelectOption>();
		cases = new List<Case>();
		mapCaseFields = new Map<String,String>();
		mapExpertFields = new Map<String,String>();
		mapProgramFields = new Map<String,String>();
		mapCaseCategoryFields = new Map<String,String>();
		
		//Set defaults in the select option list
		caseFields.add(new SelectOption('' , '--None--'));
		expertFields.add(new SelectOption('' , '--None--'));
		programFields.add(new SelectOption('' , '--None--'));
		caseCategoryFields.add(new SelectOption('' , '--None--'));
		
		//Set defaults in the map
		mapCaseFields.put('', 'STRING');
		mapCaseFields.put(null, 'STRING');
		mapExpertFields.put('', 'STRING');
		mapExpertFields.put(null, 'STRING');
		mapProgramFields.put('', 'STRING');
		mapProgramFields.put(null, 'STRING');
		mapCaseCategoryFields.put('', 'STRING');
		mapCaseCategoryFields.put(null, 'STRING');
		
		//Get All fields of Case Object and populate the select option list
		for(Schema.SObjectField field : Schema.SobjectType.Case.fields.getMap().values()) {
			
			//Populate the list
			caseFields.add(new SelectOption(field.getDescribe().getName() , field.getDescribe().getLabel()));
			mapCaseFields.put(field.getDescribe().getName(), String.valueOf(field.getDescribe().getType()));
		}
		
		//Get All fields of Expert Object and populate the select option list
		for(Schema.SObjectField field : Schema.SobjectType.Expert__c.fields.getMap().values()) {
			
			//Populate the list
			expertFields.add(new SelectOption(field.getDescribe().getName() , field.getDescribe().getLabel()));
			mapExpertFields.put(field.getDescribe().getName(), String.valueOf(field.getDescribe().getType()));
		}
		
		//Get All fields of Program Object and populate the select option list
		for(Schema.SObjectField field : Schema.SobjectType.Program__c.fields.getMap().values()) {
			
			//Populate the list
			programFields.add(new SelectOption(field.getDescribe().getName() , field.getDescribe().getLabel()));
			mapProgramFields.put(field.getDescribe().getName(), String.valueOf(field.getDescribe().getType()));
		}
		
		//Get All fields of Case Category Object and populate the select option list
		for(Schema.SObjectField field : Schema.SobjectType.Case_Category__c.fields.getMap().values()) {
			
			//Populate the list
			caseCategoryFields.add(new SelectOption(field.getDescribe().getName() , field.getDescribe().getLabel()));
			mapCaseCategoryFields.put(field.getDescribe().getName(), String.valueOf(field.getDescribe().getType()));
		}
	}
	
	//Getter list for operations
	public List<SelectOption> getOperationType() {
		
		//List of select option
		List<SelectOption> operationType = new List<SelectOption>();
		
		//Add in list
		operationType.add(new SelectOption('' , 'Operation'));
		operationType.add(new SelectOption('=' , 'Equals To'));
		operationType.add(new SelectOption('!=' , 'Not Equals To'));
		operationType.add(new SelectOption('<' , 'Less Than'));
		operationType.add(new SelectOption('>' , 'Greater Than'));
		operationType.add(new SelectOption('<=' , 'Less Than Equal To'));
		operationType.add(new SelectOption('>=' , 'Greater Than Equal To'));
		operationType.add(new SelectOption('Contains' , 'Contains'));
		operationType.add(new SelectOption('Does Not Contain' , 'Does Not Contain'));
		operationType.add(new SelectOption('StartsWith' , 'StartsWith'));
		operationType.add(new SelectOption('EndsWith' , 'EndsWith'));
		operationType.add(new SelectOption('includes' , 'Includes'));
		operationType.add(new SelectOption('excludes' , 'Excludes'));
		
		return operationType;
	}
	
	//Method for adding fielters
	public void addRows() {
		
		
	}
	
	//Method for check case reference field
	public void validateCaseReference() {
		
		//Check for null
		if(selectedCaseField != '') {
			
			//Get reference from map
			if(mapCaseFields.get(selectedCaseField) == 'REFERENCE') {
				String lookupObjName= String.valueOf(Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap().get(selectedCaseField).getDescribe().getReferenceTo());
				
				//Check if string contains user
				if(lookupObjName.contains('User'))
					lookupObjName = 'User';
				     
				//Remove starting and ending braces
                lookupObjName = lookupObjName.remove(')');
                lookupObjName = lookupObjName.remove('(');
                keyPrefixForCase = schema.getGlobalDescribe().get(lookupObjName).getDescribe().getKeyPrefix(); 
            }
            else if(mapCaseFields.get(selectedCaseField) == 'PICKLIST') {
            	
            	//Initiazlize the list
            	casePicklistValues = new List<SelectOption>();
				
				//Populate select options
            	if(Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap().get(selectedCaseField).getDescribe().isNillable())
                    casePicklistValues.add(new SelectOption('' , '--None--'));
            	
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap().get(selectedCaseField).getDescribe().getPickListValues()) {
                    casePicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
            else if(mapCaseFields.get(selectedCaseField) == 'MULTIPICKLIST') {
            	
            	//Initialize the list
            	caseMultiSelectPicklistValues = new List<SelectOption>();
            	
            	//Populate select options
            	if(Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap().get(selectedCaseField).getDescribe().isNillable())
                    
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap().get(selectedCaseField).getDescribe().getPickListValues()) {
                    caseMultiSelectPicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
		}
	}
	
	//Method for check expert reference field
	public void validateExpertReference() {
		
		//Check for null
		if(selectedExpertField != '') {
			
			//Get reference from map
			if(mapExpertFields.get(selectedExpertField) == 'REFERENCE') {
				String lookupObjName= String.valueOf(Schema.getGlobalDescribe().get('Expert__c').getDescribe().fields.getMap().get(selectedExpertField).getDescribe().getReferenceTo());
				
				//Check if string contains user
				if(lookupObjName.contains('User'))
					lookupObjName = 'User';
				       
				//Remove starting and ending braces
                lookupObjName = lookupObjName.remove(')');
                lookupObjName = lookupObjName.remove('(');
                keyPrefixForExpert = schema.getGlobalDescribe().get(lookupObjName).getDescribe().getKeyPrefix(); 
            }
            else if(mapExpertFields.get(selectedExpertField) == 'PICKLIST') {
            	
            	//Initialize the list
        		expertPicklistValues = new List<SelectOption>();
            	
            	//Populate select options
            	if(Schema.getGlobalDescribe().get('Expert__c').getDescribe().fields.getMap().get(selectedExpertField).getDescribe().isNillable())
                    expertPicklistValues.add(new SelectOption('' , '--None--'));
            	
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Expert__c').getDescribe().fields.getMap().get(selectedExpertField).getDescribe().getPickListValues()) {
                    expertPicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
            else if(mapExpertFields.get(selectedExpertField) == 'MULTIPICKLIST') {
            	
            	//Initialize the list
        		expertMultiSelectPicklistValues = new List<SelectOption>();
            	
            	//Populate select options
            	if(Schema.getGlobalDescribe().get('Expert__c').getDescribe().fields.getMap().get(selectedExpertField).getDescribe().isNillable())
                    
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Expert__c').getDescribe().fields.getMap().get(selectedExpertField).getDescribe().getPickListValues()) {
                    expertMultiSelectPicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
		}
	}
	
	//Method for check program reference field
	public void validateProgramReference() {
		
		//Check for null
		if(selectedProgramField != '') {
			
			//Get reference from map
			if(mapProgramFields.get(selectedProgramField) == 'REFERENCE') {
				String lookupObjName= String.valueOf(Schema.getGlobalDescribe().get('Program__c').getDescribe().fields.getMap().get(selectedProgramField).getDescribe().getReferenceTo());
				
				//Check if string contains user
				if(lookupObjName.contains('User'))
					lookupObjName = 'User';
				       
				//Remove starting and ending braces
                lookupObjName = lookupObjName.remove(')');
                lookupObjName = lookupObjName.remove('(');
                keyPrefixForProgram = schema.getGlobalDescribe().get(lookupObjName).getDescribe().getKeyPrefix(); 
            }
            else if(mapProgramFields.get(selectedProgramField) == 'PICKLIST') {
            	
            	//Initialize the list
        		programPicklistValues = new List<SelectOption>();
            	
            	//Populate select options
            	if(Schema.getGlobalDescribe().get('Program__c').getDescribe().fields.getMap().get(selectedProgramField).getDescribe().isNillable())
                    programPicklistValues.add(new SelectOption('' , '--None--'));
            	
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Program__c').getDescribe().fields.getMap().get(selectedProgramField).getDescribe().getPickListValues()) {
                    programPicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
            else if(mapProgramFields.get(selectedProgramField) == 'MULTIPICKLIST') {
            	
            	//Initialize the list
        		programMultiSelectPicklistValues = new List<SelectOption>();
            	
            	//Populate select options
            	if(Schema.getGlobalDescribe().get('Program__c').getDescribe().fields.getMap().get(selectedProgramField).getDescribe().isNillable())
                    
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Program__c').getDescribe().fields.getMap().get(selectedProgramField).getDescribe().getPickListValues()) {
                    programMultiSelectPicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
		}
	}
	
	//Method for check case category reference field
	public void validateCaseCategoryReference() {
		
		//Check for null
		if(selectedCaseCategoryField != '') {
			
			//Get reference from map
			if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'REFERENCE') {
				String lookupObjName= String.valueOf(Schema.getGlobalDescribe().get('Case_Category__c').getDescribe().fields.getMap().get(selectedCaseCategoryField).getDescribe().getReferenceTo());
				
				//Check if string contains user
				if(lookupObjName.contains('User'))
					lookupObjName = 'User';
				       
				//Remove starting and ending braces
                lookupObjName = lookupObjName.remove(')');
                lookupObjName = lookupObjName.remove('(');
                keyPrefixForCaseCategory = schema.getGlobalDescribe().get(lookupObjName).getDescribe().getKeyPrefix(); 
            }
            else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'PICKLIST') {
            	
            	//Initialize the list
        		caseCategoryMultiSelectPicklistValues = new List<SelectOption>();
		
            	//Populate select options
            	if(Schema.getGlobalDescribe().get('Case_Category__c').getDescribe().fields.getMap().get(selectedCaseCategoryField).getDescribe().isNillable())
                    caseCategoryMultiSelectPicklistValues.add(new SelectOption('' , '--None--'));
            	
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Case_Category__c').getDescribe().fields.getMap().get(selectedCaseCategoryField).getDescribe().getPickListValues()) {
                    caseCategoryMultiSelectPicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
            else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'MULTIPICKLIST') {
            	
            	//Initialize the list
        		caseCategoryPicklistValues = new List<SelectOption>();
		
            	//Populate select options
            	if(Schema.getGlobalDescribe().get('Case_Category__c').getDescribe().fields.getMap().get(selectedCaseCategoryField).getDescribe().isNillable())
                
                for (Schema.PicklistEntry p : Schema.getGlobalDescribe().get('Case_Category__c').getDescribe().fields.getMap().get(selectedCaseCategoryField).getDescribe().getPickListValues()) {
                    caseCategoryPicklistValues.add(new SelectOption(p.getValue(), p.getLabel()));
                }
            }
		}
	}

	//Method for search records
	public void searchRecords() {
    		
	   	try {
		     
			//Initialize the list
			cases = new List<Case>();
			
			//Query String
			String caseCategoryQuery = 'Select Id, Name, Description__c, Count__c, CC_Number__c From Case_Categories__r';
			String programQuery = 'Select Id, Name, Description__c, Title__c, P_Number__c From Programs__r';
			String expertQuery = 'Select Id, Name, Description__c, Phone__c, E_Number__c From Experts__r';
			
			//Check for blank values
			if(selectedExpertOperator != '' && selectedExpertField != '') {
				
				//Check for field type
				if(mapExpertFields.get(selectedExpertField) == 'String' || mapExpertFields.get(selectedExpertField) == 'Picklist' || 
					mapExpertFields.get(selectedExpertField) == 'Email' || mapExpertFields.get(selectedExpertField) == 'Phone' || 
					mapExpertFields.get(selectedExpertField) == 'TextArea') {
				
					if(selectedExpertOperator == '=' || selectedExpertOperator == '!=')
						expertQuery += ' WHERE ' + selectedExpertField + ' ' + selectedExpertOperator + ' \'' + selectedExpertFieldValue + '\'';
					else if(selectedExpertOperator == 'Contains' && !String.IsBlank(selectedExpertFieldValue))
						expertQuery += ' WHERE ' + selectedExpertField + ' ' + ' like \'%' + 
						String.escapeSingleQuotes(selectedExpertFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
						'%\'';
					else if(selectedExpertOperator == 'Does Not Contain' && !String.IsBlank(selectedExpertFieldValue))
						expertQuery += ' WHERE ' + '(NOT '  + selectedExpertField + ' like \'%' +  
						String.escapeSingleQuotes(selectedExpertFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +	
						'%\')';
					else if(selectedExpertOperator == 'StartsWith' && !String.IsBlank(selectedExpertFieldValue))
						expertQuery += ' WHERE ' + selectedExpertField  + ' like \'' + 
						String.escapeSingleQuotes(selectedExpertFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
						'%\'';
					else if(selectedExpertOperator == 'EndsWith' && !String.IsBlank(selectedExpertFieldValue))
						expertQuery += ' WHERE ' + selectedExpertField  + ' like \'%' + 
						String.escapeSingleQuotes(selectedExpertFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
						'\'';
				}
				else if(mapExpertFields.get(selectedExpertField) == 'MULTIPICKLIST') {
					if(selectedExpertOperator == 'includes' || selectedExpertOperator == 'excludes') {
						
						selectedExpertFieldValue = selectedExpertFieldValue.replace('[' , '(\'');
						selectedExpertFieldValue = selectedExpertFieldValue.replace(']' , '\')');
						selectedExpertFieldValue = selectedExpertFieldValue.replace(',' , ';');
						expertQuery += ' WHERE ' + selectedExpertField + ' ' + selectedExpertOperator + ' ' + selectedExpertFieldValue;
					}
				}
				else if(mapExpertFields.get(selectedExpertField) == 'Percent' || mapExpertFields.get(selectedExpertField) == 'Integer' || 
					    mapExpertFields.get(selectedExpertField) == 'Double') {

						if((selectedExpertOperator == '=' || selectedExpertOperator == '!=') && !String.IsBlank(selectedExpertFieldValue))
							expertQuery += ' WHERE ' + selectedExpertField + ' ' + selectedExpertOperator + ' ' + selectedExpertFieldValue;
						else if((selectedExpertOperator == '<' || selectedExpertOperator == '>' || selectedExpertOperator == '<=' || selectedExpertOperator == '>=') && !String.IsBlank(selectedExpertFieldValue))
							expertQuery += ' WHERE ' + selectedExpertField + ' ' + selectedExpertOperator + ' ' + selectedExpertFieldValue;
		    	}
		    	else if(mapExpertFields.get(selectedExpertField) == 'Boolean') {
		    		
		    		if(selectedExpertOperator == '=' || selectedExpertOperator == '!=')
							expertQuery += ' WHERE ' + selectedExpertField + ' ' + selectedExpertOperator + ' ' + selectedExpertFieldValue;
		    	}
		    	else if(mapExpertFields.get(selectedExpertField) == 'Date' && !String.IsBlank(selectedExpertFieldValue)) {
		    		Date d = Date.parse(selectedExpertFieldValue);
		    		expertQuery += ' WHERE ' + selectedExpertField + ' ' + selectedExpertOperator + ' ' + String.valueOf(d);
		    	}
	    		else if(mapExpertFields.get(selectedExpertField) == 'DateTime' && !String.IsBlank(selectedExpertFieldValue)) {
	    			DateTime dT = DateTime.parse(selectedExpertFieldValue);
	    			expertQuery += ' WHERE ' + 'DAY_ONLY('+ selectedExpertField +')' + ' ' + selectedExpertOperator + ' ' + String.valueOf(dT.date());
	    		}
	    		else if(mapExpertFields.get(selectedExpertField) == 'REFERENCE' && !String.IsBlank(selectedExpertFieldValue)) {
	    			if(selectedExpertOperator == '=' || selectedExpertOperator == '!=')
	    				expertQuery += ' WHERE ' + selectedExpertField + ' ' + selectedExpertOperator + ' \'' + selectedExpertFieldValue + '\'';
	    		}
			}
			
			System.debug('######ExpertQuery' + expertQuery);
			
			//Check for blank values
			if(selectedProgramOperator != '' && selectedProgramField != '') {
			
				if(mapProgramFields.get(selectedProgramField) == 'String' || mapProgramFields.get(selectedProgramField) == 'Picklist' || 
						mapProgramFields.get(selectedProgramField) == 'Email' || mapProgramFields.get(selectedProgramField) == 'Phone' || 
						mapProgramFields.get(selectedProgramField) == 'TextArea') {
					
						if(selectedProgramOperator == '=' || selectedProgramOperator == '!=')
							programQuery += ' WHERE ' + selectedProgramField + ' ' + selectedProgramOperator + ' \'' + selectedProgramFieldValue + '\'';
						else if(selectedProgramOperator == 'Contains' && selectedProgramFieldValue != '')
							programQuery += ' WHERE ' + selectedProgramField + ' ' + ' like \'%' + 
							String.escapeSingleQuotes(selectedProgramFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'%\'';
						else if(selectedProgramOperator == 'Does Not Contain' && !String.IsBlank(selectedProgramFieldValue))
							programQuery += ' WHERE ' + '(NOT '  + selectedProgramField + ' like \'%' +  
							String.escapeSingleQuotes(selectedProgramFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +	
							'%\')';
						else if(selectedProgramOperator == 'StartsWith' && !String.IsBlank(selectedProgramFieldValue))
							programQuery += ' WHERE ' + selectedProgramField  + ' like \'' + 
							String.escapeSingleQuotes(selectedProgramFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'%\'';
						else if(selectedProgramOperator == 'EndsWith' && !String.IsBlank(selectedProgramFieldValue))
							programQuery += ' WHERE ' + selectedProgramField  + ' like \'%' + 
							String.escapeSingleQuotes(selectedProgramFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'\'';
				}
				else if(mapProgramFields.get(selectedProgramField) == 'MULTIPICKLIST') {
					if(selectedProgramOperator == 'includes' || selectedProgramOperator == 'excludes') {
						
						selectedProgramFieldValue = selectedProgramFieldValue.replace('[' , '(\'');
						selectedProgramFieldValue = selectedProgramFieldValue.replace(']' , '\')');
						selectedProgramFieldValue = selectedProgramFieldValue.replace(',' , ';');
						programQuery += ' WHERE ' + selectedProgramField + ' ' + selectedProgramOperator + ' ' + selectedProgramFieldValue;
					}
				}
				else if(mapProgramFields.get(selectedProgramField) == 'Percent' || mapProgramFields.get(selectedProgramField) == 'Integer' || 
					    mapProgramFields.get(selectedProgramField) == 'Double') {

						if(selectedProgramOperator == '=' || selectedProgramOperator == '!=')
							programQuery += ' WHERE ' + selectedProgramField + ' ' + selectedProgramOperator + ' ' + 
							String.escapeSingleQuotes(selectedProgramFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '');
						else if((selectedProgramOperator == '<' || selectedProgramOperator == '>' || selectedProgramOperator == '<=' || selectedProgramOperator == '>=') && !String.IsBlank(selectedProgramFieldValue))
							programQuery += ' WHERE ' + selectedProgramField + ' ' + selectedProgramOperator + ' ' + selectedProgramFieldValue;
		    	}
		    	else if(mapProgramFields.get(selectedProgramField) == 'Boolean') {
		    		
		    		if(selectedProgramOperator == '=' || selectedProgramOperator == '!=')
							programQuery += ' WHERE ' + selectedProgramField + ' ' + selectedProgramOperator + ' ' + selectedProgramFieldValue;
		    	}
		    	else if(mapProgramFields.get(selectedProgramField) == 'Date' && !String.IsBlank(selectedProgramFieldValue)) {
		    		Date d = Date.parse(selectedProgramFieldValue);
		    		programQuery += ' WHERE ' + selectedProgramField + ' ' + selectedProgramOperator + ' ' + String.valueOf(d);
		    	}
	    		else if(mapProgramFields.get(selectedProgramField) == 'DateTime' && !String.IsBlank(selectedProgramFieldValue)) {
	    			DateTime dT = DateTime.parse(selectedProgramFieldValue);
	    			programQuery += ' WHERE ' + 'DAY_ONLY('+ selectedProgramField +')' + ' ' + selectedProgramOperator + ' ' + String.valueOf(dT.date());
	    		}
    			else if(mapProgramFields.get(selectedProgramField) == 'REFERENCE' && !String.IsBlank(selectedProgramFieldValue)) {
	    			if(selectedProgramOperator == '=' || selectedProgramOperator == '!=')
	    				programQuery += ' WHERE ' + selectedProgramField + ' ' + selectedProgramOperator + ' \'' + selectedProgramFieldValue + '\'';
	    		}
			}
			    		
			//Check for blank values    
			if(selectedCaseCategoryOperator != '' && selectedCaseCategoryField != '') {
						
				if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'String' || mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Picklist' || 
						mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Email' || mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Phone' || 
						mapCaseCategoryFields.get(selectedCaseCategoryField) == 'TextArea') {
						
						if(selectedCaseCategoryOperator == '=' || selectedCaseCategoryOperator == '!=')
							caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + selectedCaseCategoryOperator + ' \'' + selectedCaseCategoryFieldValue + '\'';
						else if(selectedCaseCategoryOperator == 'Contains' && !String.IsBlank(selectedCaseCategoryFieldValue))
							caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + ' like \'%' + 
							String.escapeSingleQuotes(selectedCaseCategoryFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'%\'';
						else if(selectedCaseCategoryOperator == 'Does Not Contain' && !String.IsBlank(selectedCaseCategoryFieldValue))
							caseCategoryQuery += ' WHERE ' + '(NOT '  + selectedCaseCategoryField + ' like \'%' +  
							String.escapeSingleQuotes(selectedCaseCategoryFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +	
							'%\')';
						else if(selectedCaseCategoryOperator == 'StartsWith' && !String.IsBlank(selectedCaseCategoryFieldValue))
							caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField  + ' like \'' + 
							String.escapeSingleQuotes(selectedCaseCategoryFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'%\'';
						else if(selectedCaseCategoryOperator == 'EndsWith' && !String.IsBlank(selectedCaseCategoryFieldValue))
							caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField  + ' like \'%' + 
							String.escapeSingleQuotes(selectedCaseCategoryFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'\'';
				}
				else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'MULTIPICKLIST') {
					if(selectedCaseCategoryOperator == 'includes' || selectedCaseCategoryOperator == 'excludes') {
						
						selectedCaseCategoryFieldValue = selectedCaseCategoryFieldValue.replace('[' , '(\'');
						selectedCaseCategoryFieldValue = selectedCaseCategoryFieldValue.replace(']' , '\')');
						selectedCaseCategoryFieldValue = selectedCaseCategoryFieldValue.replace(',' , ';');
						caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + selectedCaseCategoryOperator + ' ' + selectedCaseCategoryFieldValue;
					}
				}
				else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Percent' || mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Integer' || 
					    mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Double') {

						if(selectedCaseCategoryOperator == '=' || selectedCaseCategoryOperator == '!=')
							caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + selectedCaseCategoryOperator + ' ' + selectedCaseCategoryFieldValue;
						else if((selectedCaseCategoryOperator == '<' || selectedCaseCategoryOperator == '>' || selectedCaseCategoryOperator == '<=' || selectedCaseCategoryOperator == '>=') && !String.IsBlank(selectedCaseCategoryFieldValue))
							caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + selectedCaseCategoryOperator + ' ' + selectedCaseCategoryFieldValue;
		    	}
		    	else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Boolean') {
		    		
		    		if(selectedCaseCategoryOperator == '=' || selectedCaseCategoryOperator == '!=')
							caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + selectedCaseCategoryOperator + ' ' + selectedCaseCategoryFieldValue;
		    	}
		    	else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'Date' && !String.IsBlank(selectedCaseCategoryFieldValue)) {
		    		Date d = Date.parse(selectedCaseCategoryFieldValue);
		    		caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + selectedCaseCategoryOperator + ' ' + String.valueOf(d);
		    	}
	    		else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'DateTime' && !String.IsBlank(selectedCaseCategoryFieldValue)) {
	    			DateTime dT = DateTime.parse(selectedCaseCategoryFieldValue);
	    			caseCategoryQuery += ' WHERE ' + 'DAY_ONLY('+ selectedCaseCategoryField +')'  + ' ' + selectedCaseCategoryOperator + ' ' + String.valueOf(dT.date());
	    		}
    			else if(mapCaseCategoryFields.get(selectedCaseCategoryField) == 'REFERENCE' && !String.IsBlank(selectedCaseCategoryFieldValue)) {
	    			if(selectedCaseCategoryOperator == '=' || selectedCaseCategoryOperator == '!=')
	    				caseCategoryQuery += ' WHERE ' + selectedCaseCategoryField + ' ' + selectedCaseCategoryOperator + ' \'' + selectedCaseCategoryFieldValue + '\'';
	    		}
			}
			
			System.debug('@@@@@@' + expertQuery);
		    
			//Case query string          
			String caseQuery = 'Select Id,(' + expertQuery + '),(' + programQuery +'),(' + caseCategoryQuery + '), CaseNumber, Type, Origin, Status, Reason From Case';
			
			//Check for blank values
			if(selectedCaseOperator != '' && selectedCaseField != '') {
			
				if(mapCaseFields.get(selectedCaseField) == 'String' || mapCaseFields.get(selectedCaseField) == 'Picklist' || 
						mapCaseFields.get(selectedCaseField) == 'Email' || mapCaseFields.get(selectedCaseField) == 'Phone' || 
						mapCaseFields.get(selectedCaseField) == 'TextArea') {
					
						if(selectedCaseOperator == '=' || selectedCaseOperator == '!=')
							caseQuery += ' WHERE ' + selectedCaseField + ' ' + selectedCaseOperator + ' \'' + selectedCaseFieldValue + '\'';
						else if(selectedCaseOperator == 'Contains' && !String.IsBlank(selectedCaseFieldValue))
							caseQuery += ' WHERE ' + selectedCaseField + ' ' + ' like \'%' + 
							String.escapeSingleQuotes(selectedCaseFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'%\'';
						else if(selectedCaseOperator == 'Does Not Contain' && !String.IsBlank(selectedCaseFieldValue))
							caseQuery += ' WHERE ' + '(NOT '  + selectedCaseField + ' like \'%' +  
							String.escapeSingleQuotes(selectedCaseFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +	
							'%\')';
						else if(selectedCaseOperator == 'StartsWith' && !String.IsBlank(selectedCaseFieldValue))
							caseQuery += ' WHERE ' + selectedCaseField  + ' like \'' + 
							String.escapeSingleQuotes(selectedCaseFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'%\'';
						else if(selectedCaseOperator == 'EndsWith' && !String.IsBlank(selectedCaseFieldValue))
							caseQuery += ' WHERE ' + selectedCaseField  + ' like \'%' + 
							String.escapeSingleQuotes(selectedCaseFieldValue).replaceAll('\\*' ,'%').replaceAll('\\s+', '').replaceAll('\\s+', '') +
							'\'';
				}
				else if(mapCaseFields.get(selectedCaseField) == 'MULTIPICKLIST') {
					if(selectedCaseOperator == 'includes' || selectedCaseOperator == 'excludes') {
						
						selectedCaseFieldValue = selectedCaseFieldValue.replace('[' , '(\'');
						selectedCaseFieldValue = selectedCaseFieldValue.replace(']' , '\')');
						selectedCaseFieldValue = selectedCaseFieldValue.replace(',' , ';');
						caseQuery += ' WHERE ' + selectedCaseField + ' ' + selectedCaseOperator + ' ' + selectedCaseFieldValue;
					}
				}
				else if(mapCaseFields.get(selectedCaseField) == 'Percent' || mapCaseFields.get(selectedCaseField) == 'Integer' || 
					    mapCaseFields.get(selectedCaseField) == 'Double') {
	
						if(selectedCaseOperator == '=' || selectedCaseOperator == '!=')
							caseQuery += ' WHERE ' + selectedCaseField + ' ' + selectedCaseOperator + ' ' + selectedCaseFieldValue;
						else if((selectedCaseOperator == '<' || selectedCaseOperator == '>' || selectedCaseOperator == '<=' || selectedCaseOperator == '>=') && !String.IsBlank(selectedCaseFieldValue))
							caseQuery += ' WHERE ' + selectedCaseField + ' ' + selectedCaseOperator + ' ' + selectedCaseFieldValue;
		    	}
		    	else if(mapCaseFields.get(selectedCaseField) == 'Boolean') {
		    		
		    		if(selectedCaseOperator == '=' || selectedCaseOperator == '!=')
							caseQuery += ' WHERE ' + selectedCaseField + ' ' + selectedCaseOperator + ' ' + selectedCaseFieldValue;
		    	}
		    	else if(mapCaseFields.get(selectedCaseField) == 'Date' && !String.IsBlank(selectedCaseFieldValue)) {
		    		Date d = Date.parse(selectedCaseFieldValue);
		    		caseQuery += ' WHERE ' + selectedCaseField + ' ' + selectedCaseOperator + ' ' + String.valueOf(d);
		    	}
	    		else if(mapCaseFields.get(selectedCaseField) == 'DateTime' && !String.IsBlank(selectedCaseFieldValue)) {
	    			DateTime dT = DateTime.parse(selectedCaseFieldValue);
	    			caseQuery += ' WHERE ' + 'DAY_ONLY('+selectedCaseField+')' + ' ' + selectedCaseOperator + ' ' + String.valueOf(dT.date());
	    		}    
    			else if(mapCaseFields.get(selectedCaseField) == 'REFERENCE' && !String.IsBlank(selectedCaseFieldValue)) {
    				if(selectedCaseOperator == '=' || selectedCaseOperator == '!=')
	    				caseQuery += ' WHERE ' + selectedCaseField + ' ' + selectedCaseOperator + ' \'' + selectedCaseFieldValue + '\'';
	    		}
			}
			   
			System.debug('#####' + caseQuery);
			
			//Query to get case records
			cases = Database.query(caseQuery);
		}catch(Exception e) {
			
			//Add error on page
			ApexPages.addMessages(e);
		}
	} 
}