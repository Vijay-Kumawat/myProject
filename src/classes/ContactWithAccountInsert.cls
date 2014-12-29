public class ContactWithAccountInsert{

    public ContactWithAccountInsert(){
    
        Account acc = new Account(Name = 'TestAccount');
        insert acc;
    
        Contact con = new Contact(FirstName = 'Test' , LastName = 'PUC' , AccountId = acc.Id);
        insert con; 
    }
}