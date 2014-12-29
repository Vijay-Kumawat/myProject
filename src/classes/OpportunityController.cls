public class OpportunityController {

    public List<Opportunity> listOpportunity {get; set;}
    public Opportunity opportunity {get; set;}
    
    public OpportunityController(ApexPages.StandardController controller) {
    
        opportunity = (Opportunity)controller.getRecord();
    
        listOpportunity = new List<Opportunity>();
        
        String oppQueryString = '';
        
        //Use  getDescribe method to get all field of oportunity
        for(String oppField : Opportunity.getSobjectType().getDescribe().fields.getMap().KeySet()) {
              
              //Add field in string to pass in dunamic SOQL
              oppQueryString += oppField + ',';
        }
        
        //Dynamic SOQL to get all field detail of current opportunity
        opportunity = DataBase.query('Select ' + oppQueryString.removeEnd(',') + ' From Opportunity Where Id =\'' + opportunity.Id + '\' ');   

        for(Integer i = 0 ; i <10 ; i++ ) {
        
            listOpportunity.add(new Opportunity(Name = opportunity.Name));
        }
    }
    
    public PageReference saveOpportunityData() {
    
        try {
    
            List<Opportunity> opportunityGoingToBeInsert = new List<Opportunity>();
        
            for(Opportunity opp : listOpportunity) {
            
                if(opp.OwnerId != null) {
                    
                    Opportunity op = opportunity.clone(false,true);
                    op.OwnerId = opp.OwnerId;                   
                    opportunityGoingToBeInsert.add(op);
                }
            }
            
            if(opportunityGoingToBeInsert.size() > 0) {
                insert opportunityGoingToBeInsert;
                
                return new PageReference('/006/o');
            }
       } catch(Exception e) {
           ApexPages.addMessages(e);
       }
       return null;
    }
}