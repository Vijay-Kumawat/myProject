/*
* Description   : This is class there to display the list of Indian Cricket team Player with his wife.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/22/2012
*
* Version       : v1.0 - Create 
*/

//Class
public class IndianTeamWithWife{

    //Map
    public Map<String, Map<String, String>> mapPlayerWithWife {get; set;}
    public Map<String, String> mapPlayers {get; set;}
    
    //Calling Constructor
    public IndianTeamWithWife() {
    
        //Lists
        List<String> outerKeys = new List<String>{'1','2','3','4','5','6','7','8','9','10'};
        Set<String> innerKeysSet = new Set<String>();
        List<String> innerKeys = new List<String>();       
        List<String> values = new List<String>();
        
        //Populate the Map   
        mapPlayers = new Map<String, String>{'Virender Sehwag' => 'Anjali Sehwag', 
                                             'Gautam Gambhir' => 'Natasha Gambhir',
                                             'Virat Kohli' => 'Deepika Padokon', 
                                             'yuvraj Singh' => 'Kim Sharma',
                                             'M S Dhoni' => 'Shakshi Rawat',  
                                             'Rohit Sharma' => 'Katrina Kaif',
                                             'Irfan Pathan' => 'Kareena Kapoor',  
                                             'Ashvin' => 'Anjum Chopra',
                                             'Ashish Nehra' => 'Reshma Nehra',  
                                             'Zaheer Khan' => 'Isha joshi'};   
                                             
        //Populate List
        innerKeysSet.addAll(mapPlayers.keySet());
        innerKeys.addAll(innerKeysSet);
        values.addAll(mapPlayers.values());
        System.debug('######### Values in values'+ values);
        System.debug('######### Values in List'+ innerKeys);
        System.debug('######### Values in Int'+ outerKeys);
        
        //Map
        mapPlayerWithWife = new Map<String, Map<String, String>>(); 
    
        for(Integer i = 0; i< outerKeys.size(); i++){          
   
            mapPlayerWithWife.put(outerKeys[i],mapPlayers); 

        } 
    }
        
}