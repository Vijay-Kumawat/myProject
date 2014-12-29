public with sharing class HTTPRequestBuilder1 {

    public static void HTTPCall() {
        
        //Http Request Object
        HttpRequest req = new HttpRequest();
        
        //Setting Endpoint URL for the request
        req.setEndpoint('https://c.ap1.content.force.com/servlet/rtaImage?eid=0019000000Swx0N&feoid=00N90000009D4EY&refid=0EM90000000YD0S');
       
        //Setting Request type value
        req.setMethod('GET');
        
        //Setting time out value for the request
        req.setTimeout(60000);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('####' + res.getBody());
    } 

}