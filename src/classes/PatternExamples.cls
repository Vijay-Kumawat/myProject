//Apex class for display pattern 
public class PatternExamples {

    //Integer to hold value
    public Integer counter{get; set;}
    
    //List of list to hold pattern string
    List<List<String>> patternString{get; set;}
    
    //Constructor Calling
    public PatternExamples(){
    
        //Memory allocation
        patternString = new List<List<String>>();
    }
    
    //Method for display pattern
    public void drowPattern() {
    
        //loop through counter
        for(Integer i = 0; i < counter; i++) {
        
            //inner loop
            for(Integer j = 1; j < i; j++) {
            
                patternString[i].add('');
                patternString[j].add('*');
            }
        }    
    }
}