public without sharing class DataTableController {
public String userImage {get; set;}

    //List to hold account records
    public List<Contact> listContacts{get; set;}
    
    //Constructor Calling
    public DataTableController() {
        
        userImage = [SELECT FullPhotoUrl From User WHERE id=: UserInfo.getUserId()].FullPhotoUrl;
    
        listContacts = [SELECT ID , FirstName , LastName ,Estimation_Start_Date__c, Phone , Fax , Email,ADDTL_CONTACT__c,AccountId,Account.Name, School__r.Name FROM Contact];
    }
}