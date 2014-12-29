/**
 *  Description     :   This class is a wrapper class to hold the values returned by the Alexa web service.
 *
 *  Created Date    :   06/14/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
public with sharing class AlexaServiceWrapper {
	
	//Variables to hold the response parsed values
    public string statusString {get; set;}
    public string urlString {get; set;}
    public Integer worldWideRank {get; set;}
    public List<AlexaServiceResponseWrapper> alexaServiceWrapper {get; set;}
    
    //Calling Constructor
    public AlexaServiceWrapper() {
    	
    }
  
    //Calling Constructor
    public AlexaServiceWrapper(String statusString, String urlString, Integer worldWideRank, List<AlexaServiceResponseWrapper> alexaServiceWrapper) {
    	
    	this.statusString = statusString;
    	this.urlString = urlString;
    	this.worldWideRank = worldWideRank;
    	this.alexaServiceWrapper = alexaServiceWrapper;
    }
}