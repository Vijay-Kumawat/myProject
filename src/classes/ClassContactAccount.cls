public class ClassContactAccount{

    List<Contact> listContact;
    public List<ContactWrapper> listContactWrapper {get;set;}
    public Map<Id, Integer> countMap {get;set;}

public classContactAccount(){
        
    listContact = [SELECT Id, AccountId, Account.Name FROM Contact];
    countMap = new Map<Id, Integer>();
        
            for(Contact con : listContact){
            Integer cnt = countMap.get(con.AccountId);
                if(cnt == null){
                cnt = 0;
                }
                cnt++;            
                
                countMap.put(con.AccountId, cnt);           
             }
          
        listContactWrapper = new List<ContactWrapper>();

        if(countMap.keySet().size() > 0){
            for(Contact con : listContact) {
            
            for(Id AccountId : countMap.keySet()){               
                 
                 listContactWrapper.add(new ContactWrapper(AccountId, countMap.get(AccountId)));
            }
            }
        }
    }
    
     public class ContactWrapper {
        public String contactName {get;set;}
        public Integer totalContacts {get;set;}

    public ContactWrapper(String contactName, Integer totalContats) {
    
        this.totalContacts = totalContacts;
        this.contactName = contactName;
    }
    }
}