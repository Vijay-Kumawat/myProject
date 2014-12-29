//Wrapper Class for Convert Amazon Response in Apex Objects.
public class Obj implements Comparable{
 
  public Boolean Sel {get;set;}
  public String Name {get;set;}
  public DateTime UploadDate {get;set;}
  public Double fileSize {get;set;}
  public String objectURL {get;set;}
  public String fileSizeDetail {get;set;}
  public String filetype {get;set;}
  public Boolean sharelink {get;set;}
  public String key {get;set;}
  
  public Integer compareTo(Object compareTo){
    
    Obj wrapObj = (Obj)compareTo;
    if(UploadDate == wrapObj.UploadDate)
      return 0;
    if(UploadDate > wrapObj.UploadDate)
      return -1;
    return 1;       
  }
}