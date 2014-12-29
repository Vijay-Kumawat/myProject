/*
* Description   : This is class there to display the list of Indian Cricket team.
* 
* Created By    : Vijay Kumar Kumawat
*
* Created Date  : 10/22/2012
*
* Version       : v1.0 - Create 
*/

//Class
public class IndianTeam{

    //List
    //List<String> listTeam {get; set;}
    
    //Map
    public Map<Integer, String> mapTeam {get; set;}
    
    //Contstructor
    public IndianTeam(){
    
        //List of Indian Team
      //  listTeam = new List<String>();
      //  listTeam.add('Virender Sehwag');
      
      mapTeam = new Map<Integer, String>{1=> 'Virender Sehwag' , 2=> 'Gautam Gambhir' ,
                                     3=> 'Virat Kohli' , 4=> 'yuvraj Singh' ,
                                     5=> 'M S Dhoni' , 6=> 'Rohit Sharma' ,
                                     7=> 'Irfan Pathan' , 8=> 'Ashvin' ,
                                     9=> 'Ashish Nehra' , 10=> 'Zaheer Khan'};
                                     
      System.debug('######'+ mapTeam);
    }
}