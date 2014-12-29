public class PaypalProccessor{

    //Paypal Info Folder
    public PayPal_Info_Folder__c paypalInfo {get; set;}
    
    //String to hold value
    public  String result {set;get;}
    public  String transid {get; set;}
    public  String message {get; set;}
    public  String err {get; set;}
    public  String rawResponse {get; set;}

    //Constructor Calling
    public PaypalProccessor(ApexPages.StandardController controller) {
    
        //Get record through controller
        paypalInfo = (PayPal_Info_Folder__c)controller.getRecord();
    }

    //Method to send the request
    public String doDirectPayment() { 
  
        //Request
        Http h = new Http();
        
        //HttpRequest
        HttpRequest req = new HttpRequest();
        
        //String to hold person information
        String url = 'https://api-3t.sandbox.paypal.com/2.0/';
        string userName = 'vijay.simplyforce_api1.gmail.com';
        string password = '1367564637';
        string signature = 'Ac8FAmA7vTISnhH1Lbt1q.1pKjw9AbtnA9J33fn5KHirk9R3wckLve-x';
  
        //String to hold request string
        String doDirectRequest;
        
        doDirectRequest += '</PaymentDetails><CreditCard><CreditCardType>' + paypalInfo.Card_Type__c + '</CreditCardType><CreditCardNumber>' + paypalInfo.Card_No__c + '</CreditCardNumber>';
        doDirectRequest += '<ExpMonth>' + paypalInfo.Expire_Month__c + '</ExpMonth><ExpYear>' + paypalInfo.Expire_Year__c + '</ExpYear><CardOwner><PayerStatus>verified</PayerStatus>';
        doDirectRequest += '<PayerName><FirstName>' + paypalInfo.FirstName__c + '</FirstName><LastName>' + paypalInfo.LastName__c + '</LastName></PayerName><PayerCountry>' + paypalInfo.Country__c + '</PayerCountry>';
        doDirectRequest += '<Address><Street1>' + paypalInfo.Address1__c + '</Street1><Street2>' + paypalInfo.Address2__c + '</Street2><CityName>' + paypalInfo.City__c + '</CityName>';
        doDirectRequest += '<StateOrProvince>' + paypalInfo.State__c + '</StateOrProvince><Country>' + paypalInfo.Country__c + '</Country><PostalCode>' + paypalInfo.Zip_Code__c + '</PostalCode></Address>';
        doDirectRequest += '</CardOwner><CVV2>' + '' + '</CVV2></CreditCard></DoDirectPaymentRequestDetails>';
        doDirectRequest += '</DoDirectPaymentRequest></DoDirectPaymentReq></soap:Body></soap:Envelope>';
        
        //Set Body
        req.setBody(doDirectRequest);
        
        //Set Endpoint URL
        req.setEndpoint(url);
        
        //Set Method
        req.setMethod('POST');
        
        //Set Header
        req.setHeader('Content-length', '1753' );
        req.setHeader('Content-Type', 'text/xml;charset=UTF-8'); 
        req.setHeader('SOAPAction','');
        req.setHeader('Host','api-aa.sandbox.paypal.com');
        
        //Get Response
        HttpResponse res = h.send(req);
        
        //String to hold response body
        String xml = res.getBody();
        rawResponse = xml;
        
        //Debug Logs
        system.debug('::' + rawResponse);
        
        //Xml Stream Reader
        XmlStreamReader reader = res.getXmlStreamReader();
        
        //Get information
        result = readXMLResponse(reader,'Ack');
        
        reader = res.getXmlStreamReader();
        err = readXMLResponse(reader, 'LongMessage');
       
        //Check for success
        if (result == 'Success')
        {
        reader = res.getXmlStreamReader();
        transid = readXMLResponse(reader, 'TransactionID'); 
        
        System.debug('#####' + transid); 
        }
        else
        {
        result = err;
        }
        return result;
        }
        
    //Method to read Response
    public String readXMLResponse(XmlStreamReader reader, String sxmltag) {
    
        String retValue; 
        
        //Read through the XML
        while(reader.hasNext())
        {
        if (reader.getEventType() == XmlTag.START_ELEMENT)
        {
          if (reader.getLocalName() == sxmltag) {
            reader.next();
            if (reader.getEventType() == XmlTag.characters)
            {
              retValue = reader.getText();
            }
          }
        }
        reader.next();
        }
                        
        return retValue;
        }
        
    //Method
    public PageReference pay() {
  
        //Check for null
        err = '';
        if (paypalInfo.FirstName__c == '')
        err = err + 'You must enter a First Name.\n';
        if (paypalInfo.LastName__c == '')
        err = err + 'You must enter a Last Name.\n';
        if (paypalInfo.Address1__c == '')
        err = err + 'You must enter an Address.\n';
        if (paypalInfo.City__c == '')
        err = err + 'You must enter a City.\n';
        if (paypalInfo.State__c == '')
        err = err + 'You must enter a State.\n';
        if (paypalInfo.Zip_Code__c == '')
        err = err + 'You must enter a Zip.\n';
        if (paypalInfo.Card_No__c == '')
        err = err + 'You must enter a Credit Card Number.\n';
        if (paypalInfo.Expire_Month__c.length() != 2)
        err = err + 'Expiration month must be in the format MM.\n';
        if (paypalInfo.Expire_Year__c.length() != 4) 
        err = err + 'Expiration year must be in the format YYYY.\n';
        
        if (paypalInfo.Amount__c == '0')
        {
        err += 'Amount 0 can not process.\n';
        message = err;
        }  
        message = err;
        if (err == '')
        {
        System.debug('@@@@@@@@@@@@');
        message = doDirectPayment();
        
        }
        
        if (message == 'Success')
        {
        
            System.debug('###'  + message);
            //Message for successful transfer
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO , 'Transaction Succeeded'));

        }
        else
        {
        
            //Message for error
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.WARNING , 'Transaction Aborded'));
        }
        return null;
    }
}