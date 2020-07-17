trigger CreatePdfTrigger on Lab_Result__c (after insert) {
    CreatePdfTriggerHandler.handlePdfCreate(Trigger.new);
}