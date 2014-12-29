/*
* Description   : This is class there to Show the Contact Name on VF Page With the help of Wrapper Class.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 01/28/2013

* Version       : v1.0 - Create 
*/
//Class Declaration
public class ContactWithWrapperClassBinding {

    //Wrapper List
    public List<WrapperContact> listWrapper {get; set;}
    
    //Calling Constructor
    public ContactWithWrapperClassBinding() {
    
        //Memory Allocation to wrapper List
        listWrapper = new List<WrapperContact>();
      
        //Loop through contacts
        for(Contact con : [SELECT ID, FirstName , LastName FROM Contact]) {
        
            //Populate wrapper list with values
            listWrapper.add(new WrapperContact(false , con));
        }
    }
    
    //Method having save functionality
    public void save() {
        
        //Memory Allocation to the Contact List
        List<Contact> contactList = new List<Contact>();
    
        //Loop through Contact wrapper
        for(WrapperContact wrap : listWrapper) {
        
            if(wrap.selected == true) {
            
                contactList.add(wrap.contact);
            }
        }
            
        //Check for size
        if(contactList.size() > 0) {
             update contactList;
        }
    }
    
    //Wrapper Class
    public class WrapperContact {

        //Variable 
        public Contact contact {get ; set ; }
        public Boolean selected {get ; set ; }

        //Calling Constructor
        public WrapperContact(Boolean selected , Contact contact) {
        
            this.selected = selected;
            this.contact = contact;
        }
    }
}