public class CustomStudentCon {

    public List<Contact> listContact {get; set;}
    
    public CustomStudentCon() {
        
        listContact = [SELECT ID, LastName, Fax, Account.Name, Phone FROM Contact];
    }
    
    public void save() {
    
        if(listContact.size() >0) {
            update listContact;
        }
    }
}