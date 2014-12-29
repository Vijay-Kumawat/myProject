/**
 *  Description     :   Apex class to hold the country names and their code value returned through the Alexa web service.
 *
 *  Created Date    :   06/12/2013
 *
 *  Revision Logs   :   V1.0 - Created                    
 **/
global class AlexaServiceResponseWrapper implements Comparable {
	
	//Variables
	public string countryCode {get; set;}
	public string countryName {get; set;}
	public Integer countryWiseRank {get; set;}
	
	//Constructor
	public AlexaServiceResponseWrapper(String countryName, String countryCode, Integer countryWiseRank) {
		
		this.countryCode = countryCode;
		this.countryName = countryName;
		this.countryWiseRank = countryWiseRank;
	}
	
	//Implement the compareTo() method
    global Integer compareTo(Object compareTo) {
    	
    	//Wrapper class Instance
        AlexaServiceResponseWrapper compareToResponse = (AlexaServiceResponseWrapper)compareTo;
        
        if (countryWiseRank == compareToResponse.countryWiseRank) return 0;
        if (countryWiseRank > compareToResponse.countryWiseRank) return 1;
        return -1;        
    }
}