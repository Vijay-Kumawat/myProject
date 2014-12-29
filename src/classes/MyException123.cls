public class MyException123 {

    Public String cnt {get; set;} 

    //Calling Constrcutor
    public MyException123() {
    
        cnt = '12';
    }
    
    //Calling Methods
    public void myInteger() {
    
        if(cnt == '13') {
        
            throw new customException('Unlucky Number');
        }
    }
}