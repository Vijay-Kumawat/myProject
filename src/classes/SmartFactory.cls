/**
 *  Description :   Apex class having generic methods for test data creation is going to be use in test classes.
 * 
 *  Created By  :   Vijay Kumawat
 *
 *  Note        :   Apex class taken from SmartFactory Package.
 * 
 *  Created Date:   8/7/2013
 * 
 *  Revision Logs:  V1.0 - Created
 *                  
 *                  
 **/ 

public with sharing class SmartFactory {
    
    //Variable to increase test coverage without creating custom objects (In case this is true)
    public static boolean FillAllFields = false;

    // Key : SobjectAPIName For ex. Account (API Name)
    // Value : Map<String, Schema.SObjectField>, field map (k:fieldname, v:Schema.Sobjectfield)
    private static final Map<String, Map<String, Schema.SObjectField>> FieldMapCache = new Map<String, Map<String, Schema.SObjectField>>();

    //Map that represents the relationship between all sObject names(keys) to sObject tokens (values)
    private static final Map<String, Schema.SObjectType> GlobalDescribe = Schema.getGlobalDescribe();

    // Key: sobject.field
    // Value: first picklist value
    private static final Map<String, String> DefaultPicklistValue = new Map<String, String>();

    //Can't map by Schema.sObjectType, use object name String instead
    public static map<String, set<String>> ExcludedFields = new map<String, set<String>>{
        'All' => new set<String>{'OwnerId', 'LastModifiedById', 'CreatedById', 'LastModifiedDate', 'CreatedDate'},
        'Account' => new set<String>{'FirstName', 'LastName'}
    };

    // Include nillable fields
    public static map<String, set<String>> IncludedFields = new map<String, set<String>>();

    //Method to create sObject without Populating lookups
    public static SObject createSObject(String objectType) {
        return createSObject(objectType, false);
    }

    //Method to create list of sObject with or without populating lookups based on flag value
    public static List<SObject> createSObjectList(String objectType, boolean cascade, Integer numberOfObjects) {

        List<SObject> sos = new List<SObject>();
        for( Integer i=0; i<numberOfObjects; i++ )
        sos.add(createSObject(objectType, cascade, i));
        return sos;
    }
    
    //Method to create sObject records with exception handling capability
    public static SObject createSObject(String objectType, boolean cascade, Integer counter) {
        
        System.debug('Creating ' + objectType);
        Schema.sObjectType token = GlobalDescribe.get(objectType);
        
        if (token == null) {
            throw new UnsupportedObjectTypeException('Unsupported ObjectType ' + objectType);
        }

        SObject obj = token.newSObject();

        for (Schema.SObjectField field : fieldMapFor(objectType).values()) {
            setFieldValue(obj, field, cascade, counter);
        }
        
        return obj;
    }

    //Method for creating sObject based on parameters
    public static SObject createSObject(String objectType, boolean cascade) {
        return createSObject(objectType, cascade, 1);
    }

    /**
    Returns a field map for a given sobject.
    
    Note : this method is kept public for Test cases to share the same field map info, without requiring a field desribe.
    
    @param objectType sobject api name for ex. Account
    @returns FieldMap [Key:FieldName,Value:Schema.SObjectField]
    */
    public static Map<String, Schema.SObjectField> fieldMapFor(String objectType) {
        
        Map<String, Schema.SObjectField> fieldMap = null;
        String normalizedObjectType = objectType.toLowerCase();

        if (FieldMapCache.containsKey(normalizedObjectType)) {
            fieldMap = FieldMapCache.get(normalizedObjectType);
        } else {
            fieldMap = GlobalDescribe.get(objectType).getDescribe().fields.getMap();
            // cache it for next use
            FieldMapCache.put(normalizedObjectType, fieldMap);
        }
    
        return fieldMap;
    }

    //method to get the default picklist fields values
    static String getDefaultPicklistValue(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
        String key = obj.getSObjectType() + '.' + fieldDescribe.getName();

        if (!DefaultPicklistValue.containsKey(key)) {
            List<Schema.PicklistEntry> entries = fieldDescribe.getPicklistValues();
            String value = entries.size() > 0 ? entries[0].getValue() : null;
            DefaultPicklistValue.put(key, value);
        }

        return DefaultPicklistValue.get(key);
    }

    //Excluding fields for whom mapping is not possible by Schema.sObjectType
    static boolean isExcludedField(Schema.DescribeFieldResult fieldDescribe) {
        return ExcludedFields.get('All').contains(fieldDescribe.getName());
    }

    //Excluding fields for whom mapping is not possible by Schema.sObjectType
    static boolean isExcludedField(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
        set<String> fields = ExcludedFields.get(obj.getSObjectType().getDescribe().getName());
        return fields == null ? false : fields.contains(fieldDescribe.getName());
    }

    //Determining which fields have values with them
    static boolean isIncludedField(SObject obj, Schema.DescribeFieldResult fieldDescribe) {
        set<String> fields = includedFields.get(obj.getSObjectType().getDescribe().getName());
        return fields == null ? false : fields.contains(fieldDescribe.getName());
    }

    //Method for determining whether fields are of Personal Account type or Not
    static boolean isPersonAccountField(Schema.DescribeFieldResult fieldDescribe) {
        
        Boolean isPersonAccountEnabled = fieldMapFor('Account').get('IsPersonAccount') != null;
        set<string> skipPersonAccountFields = new set<string>{ 'Salutation' };
    
        Boolean CustomPerson = fieldDescribe.isCustom() && fieldDescribe.getName().endsWith('pc');
        Boolean StandardPerson = !fieldDescribe.isCustom() && fieldDescribe.getName().startsWith('Person');

        return CustomPerson || StandardPerson ||
            (isPersonAccountEnabled && skipPersonAccountFields.contains(fieldDescribe.getName()));
    }

    //Method to set fields values
    static void setFieldValue(SObject obj, Schema.SObjectField field, boolean cascade) {
        setFieldValue(obj, field, cascade, 0);
    }
    
    /*Describe Field Result Methods
      isCalculated => Returns true if the field is a custom formula field, false otherwise.
      isCreateable => Returns true if the field can be created by the current user, false otherwise.
      isNillable   => Returns true if the field is nillable, false otherwise. A nillable field can have empty content.
      getType      => Returns one of the DisplayType enum values, depending on the type of field. (Getting Data Type for the field)*/
      
    
    //Method to set value of all the required fields for any sObject
    static void setFieldValue(SObject obj, Schema.SObjectField field, boolean cascade, Integer counter) {
        
        //Getting field describe results
        Schema.DescribeFieldResult fieldDescribe = field.getDescribe();

        //Checking for all required fields
        if (fieldDescribe.isCreateable() &&
        (
        isIncludedField(obj, fieldDescribe) ||
        (
        (
        (!fieldDescribe.isNillable() ||
        FillAllFields) ||
        (fieldDescribe.getType() == Schema.DisplayType.Reference && cascade) // always fill references with cascade
        ) &&
        !isExcludedField(fieldDescribe) &&
        !isExcludedField(obj, fieldDescribe) &&
        !isPersonAccountField(fieldDescribe)
        )
        )
        ) {
            //Populating fields with appropriate values based on data types
            if (fieldDescribe.getType() == Schema.DisplayType.base64) {
                obj.put(field, blob.valueOf(counter.format()));
            } else if (fieldDescribe.getType() == Schema.DisplayType.Boolean) {
                obj.put(field, false);
            } else if (fieldDescribe.getType() == Schema.DisplayType.Combobox) {
                obj.put(field, counter.format());
            } else if (fieldDescribe.getType() == Schema.DisplayType.Currency) {
                obj.put(field, counter);
            } else if (fieldDescribe.getType() == Schema.DisplayType.Date) {
                obj.put(field, Date.today());
            } else if (fieldDescribe.getType() == Schema.DisplayType.DateTime) {
                obj.put(field, DateTime.now());
            } else if (fieldDescribe.getType() == Schema.DisplayType.Double) {
                obj.put(field, counter);
            } else if (fieldDescribe.getType() == Schema.DisplayType.Email) {
                obj.put(field, 'test' + counter.format() + '@test.com');
            } else if (fieldDescribe.getType() == Schema.DisplayType.EncryptedString) {
                obj.put(field, 's');
            } else if (fieldDescribe.getType() == Schema.DisplayType.Id) {
                //System.debug('Id field ' + fieldDescribe.getName());
            } else if (fieldDescribe.getType() == Schema.DisplayType.Integer) {
                obj.put(field, counter);
            } else if (fieldDescribe.getType() == Schema.DisplayType.MultiPicklist) {
                obj.put(field, getDefaultPicklistValue(obj, fieldDescribe));
            } else if (fieldDescribe.getType() == Schema.DisplayType.Percent) {
                obj.put(field, counter);
            } else if (fieldDescribe.getType() == Schema.DisplayType.Phone) {
                obj.put(field, '123-456-7890');
            } else if (fieldDescribe.getType() == Schema.DisplayType.Picklist) {
                obj.put(field, getDefaultPicklistValue(obj, fieldDescribe));
           /* } else if (fieldDescribe.getName() == 'UserName' && fieldDescribe.getType() == Schema.DisplayType.String) {
                obj.put(field, 'a@a.com'); */              
            } else if (fieldDescribe.getType() == Schema.DisplayType.String) {
                obj.put(field, counter.format());
            } else if (fieldDescribe.getType() == Schema.DisplayType.Reference) {
                String referenceObjectType = fieldDescribe.getReferenceTo()[0].getDescribe().getName();
            
            if (referenceObjectType == 'RecordType') {
                setRecordType(obj);
            } else if (cascade && referenceObjectType != obj.getSObjectType().getDescribe().getName()) {
                // TODO avoid infinite loop for same-type references
                System.debug('Creating reference to ' + referenceObjectType + ' for field ' + obj.getSObjectType().getDescribe().getName() + '.' + fieldDescribe.getName());
                SObject reference = createSObject(referenceObjectType);
                System.debug('Inserting ' + reference);
                insert reference;
                obj.put(field, reference.Id);
            }
            } else if (fieldDescribe.getType() == Schema.DisplayType.TextArea) {
                obj.put(field, counter.format());
            } else if (fieldDescribe.getType() == Schema.DisplayType.Time) {
                obj.put(field, Time.newInstance(0, 0, 0, 0));
            } else if (fieldDescribe.getType() == Schema.DisplayType.URL) {
                obj.put(field, 'http://test' + counter + '.com');
            } else {
                System.debug('Unhandled field type ' + fieldDescribe.getType());
            }
        }
    }

    /*If an sObject has a record type associated with it, you can access information about the record type using the RecordTypeInfo object methods. Where
      isAvailable                => Returns true if this record type is available to the current user, false otherwise.
      getRecordTypeId            => Returns the ID of this record type.
      getName                    => Returns the name of this record type. (Name stand for label).
      isDefaultRecordTypeMapping => Returns true if this is the default record type mapping, false otherwise */
            
    //Generic method for setting value of record type value with default one
    static void setRecordType(SObject obj) {
        
        //List to hold the Record Type info for any sObject
        List<Schema.RecordTypeInfo> recordTypes = obj.getSObjectType().getDescribe().getRecordTypeInfos();

        //If we have addition record types for sObject
        if (recordTypes.size() > 1) { // all objects have default Master type
            //System.debug('RecordTypes ' + recordTypes);
            
            //Loop through list of record types
            for (Schema.RecordTypeInfo recordType : recordTypes) {
                if (recordType.isAvailable() && recordType.isDefaultRecordTypeMapping()) {
                    obj.put('RecordTypeId', recordType.getRecordTypeId());
                }
            }
        }
    }
}