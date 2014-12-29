/*
* Description   : This is class there to save meeting records.
* 
* Created By    : 
*
* Created Date  : 06/24/2013
*
* Version       : v1.0 - Create 
*/

public class MeetingController {

    //Meeting Instance
    public Meeting__c meeting {get; set;}
    
    //List to hold task
    public List<Task__c> listOfTask {get; set;}
   
    //Boolean variable
    public Boolean isValidate {get; set;}
    
    //User Id
    Id userId;

    //Constructor Calling
    public MeetingController(ApexPages.StandardController controller) {
    
        //Query to fetch record
        meeting = [SELECT ID , Name , Client__c , Date_of_Meeting__c , Notes__c , Dial_In_Info__c , Agenda_Items__c , 
                   Notes_on_Agenda_Topics__c FROM Meeting__c];
        
        //Get User record
        User user1 = [SELECT ID , FirstName FROM User WHERE ID =: UserInfo.getUserID() LIMIT 1];
        
        //Set default
        isValidate = false;
        listOfTask = new List<Task__c>();
        listOfTask.add(new Task__c(Owner_Picklist__c = user1.FirstName));
    }
    
    //Method to save meeting 
    public PageReference saveMeeting() {
    
        //Update
        update meeting;
        
        //return
        return new PageReference('/'+ meeting.Id);
    }
    
    //Save & New Method for meeting
    public PageReference saveAndNew() {
    
        //Update
        update meeting;
        
        //return
        return new PageReference('/a0N/e?retURL=%2Fa0N%2Fo');
    }
    
    //Method for copy the content of Agenda Items
    public void copyContent() {
    
        //Check for null
        if(meeting.Agenda_Items__c != null) {
        
            //populate the field
            meeting.Notes_on_Agenda_Topics__c = meeting.Agenda_Items__c;
        }
    }
    
    //Method for create task for another user
    public void createTaskForAnotherUser() {
    
        //Get User record
        User user1 = [SELECT ID , FirstName FROM User WHERE FirstName = 'xyz' LIMIT 1];
        
        //Create task
        listOfTask.add(new Task__c(Owner_Picklist__c = user1.FirstName));
    }
    
    //Method for save and generate tasks now
    public void saveAndGenerateTasksNow() {
    
        //Generic Method
        saveAndGenerateTasks();
        
        //check for value
        if(isValidate)
        
            //Method for create task
            createTaskForAnotherUser();
    }
    
    //Method for save and generate tasks later
    public void saveAndGenerateTasksLater() {
    
        //Generic Method
        saveAndGenerateTasks();
    }
    
    //Page Reference Method for save task
    public PageReference saveTask() {
    
        //Update
        update meeting;
        
        //return
        return new PageReference('/'+ meeting.Id);
    }
    
    //Method for save and generate tasks(Generic Method)
    public void saveAndGenerateTasks() {
    
        //Create a savepoint to rollbak the transaction in case of exception
        SavePoint sp = database.setSavePoint();

        try {
            //String to hold value
            String inputString = listOfTask[0].InputTask__c;
            
            //List to hold task record
            List<Task__C> tasks = new List<Task__c>();
            
            //Check for size
            if(inputString.length() > 0) {
            
                //Looop through string and split with line break
                for(String str : inputString.split('\t\r\n')) {
                
                    //List to hold values
                    List<String> stringValue = new List<String>();
                    
                    //Split the string with .
                    stringValue = str.split('\\.');
                    
                    //Create task
                    Task__C task = new Task__c();
                    
                    //Check for size
                    if(stringValue.size() == 2) {
                      
                        //populate the field with values
                        task.Name = stringValue[0];
                        task.Estimated_Due_Date__c = Date.Parse(stringValue[1]);
                        task.Owner_Picklist__c = listOfTask[0].Owner_Picklist__c;
                        task.Meeting__c = meeting.Id;
                        
                        //populate the list with record
                        tasks.add(task);
                    }
                    else
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please enter a valid format ' + stringValue[0]+ '.Valid Date'));
                }
            }
        
            //Insert task
            if(tasks.size() > 0) {
                insert tasks;
                
                //Set value
                isValidate = true;
            }
        }
        catch(Exception e) {
        
            //Rollback the transaction
            database.rollback(sp);
            
            //Add error message
            ApexPages.addMessages(e);    
        }
    }
}