trigger Trigger_Vijay on Vijay__c (before insert , before update , before delete , after insert , after update , after delete) {

for(Vijay__c v : Trigger.new) {

    System.debug('####');
}

}