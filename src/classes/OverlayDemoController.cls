public class OverlayDemoController{
    public Contact cnt {get;set;}
    public OverlayDemoController(){
        cnt = [select id, email, firstname, phone, lastname from Contact limit 1];
    }
    
    public pagereference saveRecord(){
        List<contact> contacts = [select id, name from contact];
        List<Contact> users = [select id, name from Contact];
        List<account> accounts = [select id, name from account];
        List<lead> leads = [select id, name from lead];
        List<case> cases = [select id from case];
        
        upsert cnt;
        return null;
    }
}