/**
*  Description      :   Class to retrieve out current logged in user IP address.
*
*  Created By       :   Abhinav Sharma
*
*  Created Date     :   02/07/2014
*
*  Revision Logs    :   V_1.0 - Created
*
**/    
public class IPAddress {
    
    //Variable to hold the IP Address value for current logged in user
    public String ipAddress {get; set;}
        
    //Constructor
    public IPAddress() {
    
        //Map to hold current URL header parameters
        Map<String, String> mapHeaders = ApexPages.currentPage().getHeaders();   
        
        /*@@@@ mapHeaders {
            Accept=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp 
            Accept-Encoding=gzip,deflate,sdch, 
            Accept-Language=en-US,en;q=0.8, 
            CipherSuite=RC4-MD5 TLSv1.2 128-bits, 
            Connection=keep-alive, 
            Host=c.ap1.visual.force.com, 
            User-Agent=Mozilla/5.0 (Windows NT 6.1; WOW64) 
            AppleWebKit/537.36 (KHTML, like Gecko) 
            Chrome/32.0.1700.107 Safari/537.36, 
            X-Salesforce-Forwarded-To=ap1.salesforce.com, 
            X-Salesforce-SIP=122.161.114.37
        }*/
        
        //Proceed further only and only if map of header parameter have not null value with it
        if(mapHeaders != null) {
            ipAddress = mapHeaders.get('True-Client-IP');
            if(ipAddress == null){
                ipAddress = mapHeaders.get('X-Salesforce-SIP');
            }
        }
    }
}