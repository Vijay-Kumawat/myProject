/**
 *  Description   :   Test class for Apex class "SmartFactory"
 * 
 *  Created By    :   Vijay Kumawat
 *
 *  Note          :   Apex class taken from SmartFactory Package.
 * 
 *  Created Date  :   8/7/2013
 * 
 *  Revision Logs :   V1.0 - Created
 *                  
 *  Coverage      :   93%              
 **/
 
@isTest
private class Test_SmartFactory {

    static {
        SmartFactory.FillAllFields = true; // increase test coverage without creating custom objects
    }
    
    //Using SmartFactory in your tests to create objects
    static testMethod void createsSingleObjectWithSingleRequiredStringField() {
        
        //Insert sObject
        Account account = (Account)SmartFactory.createSObject('Account');
        insert account;
        
        //Assert for Results
        System.assert(account.Id != null);
        System.assert(account.Name != null);
    }

    //To cascade and create lookup objects:
    static testMethod void createsObjectWithCascadeSetsLookupField() {
        
        //Insert child sObject in cascading with Parent 
        Contact contact = (Contact)SmartFactory.createSObject('Contact', true);
        insert contact;
        
        //Assert for Results
        System.assert(contact.Id != null);
        System.assert(contact.AccountId != null);
    }

    //To Create Child object without cascading with Parent Object
    static testMethod void createsObjectWithoutCascadeDoesNotSetLookupField() {
        
        //Insert Child without Parent
        Contact contact = (Contact)SmartFactory.createSObject('Contact', false);
        insert contact;
        
        //Assert for results
        System.assert(contact.AccountId == null);
    }
    
    //Testing Exception Case 
    static testMethod void createObjectWithUnsupportedTypeThrowsException() {
        try {
                SmartFactory.createSObject('Unsupported');
                System.assert(false);
            } catch (UnsupportedObjectTypeException ex) {
                System.assert(true);
        }
    }

    //To create list of sObjects
    static testMethod void creating101UniqueRecords() {

        List<SObject> contactsAsSObjects = SmartFactory.createSObjectList('Contact', false, 50);
        insert contactsAsSObjects;
        
        for (SObject s : contactsAsSObjects)
        {
            Contact c = (Contact) s;
            System.assert(c.Id != null);
        }
    }

    /**
    Reproduces this issue
    https://github.com/mbotos/SmartFactory-for-Force.com/issues/3
    */
    /*
        static testMethod void loadTestWith100PlusAccountNContacts() {
         for (Integer idx = 0; idx <= 101; idx++)
         Account account = (Account)SmartFactory.createSObject('Account');
    for (Integer idx = 0; idx <= 101; idx++)
         Contact cont = (Contact)SmartFactory.createSObject('Contact');
        }
    */
}