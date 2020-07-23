trigger CreatePdfTrigger on Lab_Result__c (after update) {
    CreatePdfTriggerHandler.handlePdfCreate(Trigger.newMap);
}