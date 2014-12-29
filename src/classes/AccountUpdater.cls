//Class
public class AccountUpdater {

    //Future annotation to mark the method as async.
    @Future(callout=true)
    
    //Method
    public static void updateAccount(String id, String name) {
    
        //Construct an HTTP request
        HttpRequest req = new HttpRequest();
        
        //Set the end point
        req.setEndpoint('http://cheenath.com/tutorial/sfdc/sample1/data.txt');
        
        //Set the method
        req.setMethod('GET');
        
        //Send the request
        Http http = new Http();
        
        //Response
        HttpResponse res = http.send(req);
        
        //Check the response
        if (res.getStatusCode() == 200) {
        
            //Update account
            Account acc = new Account(Id=id);
            
            //Populate the description field with the response body
            acc.Description = res.getBody();
            update acc;
            
        } else {
        
            //Debug logs in case of failure
            System.debug('Callout failed: ' + res);
        } 
    }
}