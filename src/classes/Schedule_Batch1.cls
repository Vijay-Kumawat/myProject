global class Schedule_Batch1 implements Schedulable {

    //String
    String runBatch;
    
    //Execute Method
    global void execute(SchedulableContext sc) {
    
        //Schedule Class Constructor
        Schedule_Batch1 controller = new Schedule_Batch1();
        
        Batch1 controllerBatch = new Batch1();
        
        //String to hold the time interval
        runBatch = '20 30 05 * * 3-7 *';
        
        //Schedule Method
        System.Schedule('Property Upload' , runBatch , controller);
        
        database.executeBatch(controllerBatch, 200);
    }
}