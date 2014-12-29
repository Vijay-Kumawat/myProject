global class ToolingAPI {

    webservice static void getCustomObjectId() {
    
        //Http Request
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
            req.setHeader('Content-Type', 'application/json');
            
            String toolingendpoint = 'https://ap1.salesforce.com/services/data/v30.0/tooling/';
            String s = '01I900000005omk';
            
            //Query for custom fields
            toolingendpoint += 'query/?q=select+id,DeveloperName+from+CustomObject+Where+Id=\'' + s + '\'';
            req.setEndpoint(toolingendpoint);
            req.setMethod('GET');
            
            Http h = new Http();
            HttpResponse res = h.send(req);
            
            //Loop through string 
            for(String str : res.getBody().split('"attributes"')) {
                
                //Conditional statement for store search record
                String st = String.valueOf(str.substringAfter('"DeveloperName":"').substringBefore('"') + '-' + '');    
                
            }
    }
}