public class PagingController {

    public Integer currentMonth = Integer.valueOf(String.valueOf(Date.Today().Month()));
    public string qry;

    public Integer getReccount() {
        return setCon.getResultSize();
    }
    
    Public void Next(){
    
        qry='select name, Phone , CreatedDate from Account WHERE CreatedDate.Month() > currentMonth(+1)';
        setCon.next();        
    }

    Public void Previous(){
        qry='select name, Phone , CreatedDate from Account WHERE CreatedDate.Month() < currentMonth(-1)';
        setCon.previous();
    }

    public ApexPages.StandardSetController setCon {get {
            if(setCon == null) {setCon = new ApexPages.StandardSetController(Database.getQueryLocator(qry));
            }
            setCon.setPageSize(10);
            return setCon;
        }set;
    }
    public List<Account> getAccount() {
         return (List<Account>) setCon.getRecords();
    }
}