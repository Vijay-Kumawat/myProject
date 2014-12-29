public class ContactDetails{

    //List
    public List<Contact> contact{get; set;}
      
      //Constructor
      public ContactDetails(ApexPages.standardController controller){
      
      contact = [SELECT ID, FirstName , LastName, Email, Fax FROM Contact];
      }
        
}