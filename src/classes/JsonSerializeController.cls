global class JsonSerializeController {
    
    webService Static String jsonSerializer() {
        Account acc = [SELECT Image_Folder__c from Account Where Id =: '0019000000Swx0N'];
        System.debug('@@@@@acc.Image_Folder__c' + acc.Image_Folder__c);
        //String str = JSON.serialize(acc.Image_Folder__c);   
        //System.debug('@@@@@strstrstr' + str);
        return acc.Image_Folder__c;
    }
}