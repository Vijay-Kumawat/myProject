/**
 *  Description     :   This class is to build JSON Parser object with the help of response body.
 *
 *  Created Date    :   06/14/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
public with sharing class JSONParserBuilder {

    //Method to build JSON Parser object with help of response body
    public static AlexaServiceWrapper parseJSONForResponseValues(String siteURL) { 
        
        //Wrapper Instance
        AlexaServiceWrapper alexaRankServiceWrapper = new AlexaServiceWrapper();
        
        //Memory allocation to wrapper list
        alexaRankServiceWrapper.alexaServiceWrapper = new List<AlexaServiceResponseWrapper>();
        
        //Variable to hold the individaul country values
        Integer individualCountryRank;
        String individualCountryCode;
        String individualCountryName;
        
        //Map to hold the list custom setting values
        Map<String, Countries__c> countriesMap = Constants.COUNTRIES_MAP;
    
        //Create a request for address validation for Alexa web service callout
        HTTPRequest request = HTTPRequestBuilder.createAlexaRankRequest(siteURL);
    
        //Do callount and get the response
        HttpResponse response = HTTPResponseRetriever.doValidate(request);
    
        //Parse response and hold it in salesforce custom wrapper object and populate wrapper instance
        String responseBody = HTTPResponseParser.parseAlexaRankResponse(response); 
        
        //JSON Parser object
        JSONParser parser = JSON.createParser(responseBody);
         
        //Parsing response for values
        while (parser.nextToken() != null) {
            
            //Checking for Status value
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == Constants.STATUS)) {
                
                //Get the value
                parser.nextValue();
                
                //Populate string with status value
                alexaRankServiceWrapper.statusString = parser.getText();
                
            }
            
            //Checking for URL value
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == Constants.URL)) {
                
                //Get the value
                parser.nextValue();
                
                //Populate string with URL Value
                alexaRankServiceWrapper.urlString = parser.getText();
                alexaRankServiceWrapper.urlString = alexaRankServiceWrapper.urlString.removeEnd('/');
            }
            
            //Checking for Worldwide Rank value
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == Constants.RANK)) {
                
                //Get the value
                parser.nextValue();
                System.debug('@@@@@ value in rank ' + parser.getText());
                //Populate String with the worldwide rank value
                if(alexaRankServiceWrapper.urlString !='404' && alexaRankServiceWrapper.statusString != Constants.ERROR && parser.getText() != '') {
                    alexaRankServiceWrapper.worldWideRank = Integer.valueOf(parser.getText());
                } else {
                    alexaRankServiceWrapper.worldWideRank = null;
                }
            }
                
            //Checking for Individual Country stats
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == Constants.COUNTRIES)) {
            
                //Get the value
                parser.nextToken();
                
                while(parser.getCurrentToken() != JSONToken.END_OBJECT) {
            
                    //Move to next token value
                    parser.nextToken();
                    
                    //Checking for value in map corresponding to the key
                    if(countriesMap.containsKey(parser.getText().toUpperCase())) {
                            
                        //Populating variable with Individual Country code value
                        individualCountryCode = parser.getText().toUpperCase();
                        
                        //Getting corresponding parameters from custom setting
                        individualCountryName = countriesMap.get(individualCountryCode).Country_Name__c;
                        
                        //Move to value corresponding to the token
                        parser.nextValue();
                            
                        //Country wise rank value
                        individualCountryRank = Integer.valueOf(parser.getText());
                    
                        //Populate wrapper list with values
                        alexaRankServiceWrapper.alexaServiceWrapper.add(new AlexaServiceResponseWrapper(individualCountryName, individualCountryCode, individualCountryRank));
                    }   
                }           
            }
                    
            //Sort the Wrapper
            alexaRankServiceWrapper.alexaServiceWrapper.sort();
            alexaRankServiceWrapper = new AlexaServiceWrapper(alexaRankServiceWrapper.statusString, alexaRankServiceWrapper.urlString, alexaRankServiceWrapper.worldWideRank, alexaRankServiceWrapper.alexaServiceWrapper);
        }
        
        //Return value
        return alexaRankServiceWrapper;
    }
}