public with sharing class CreatePdfTriggerHandler {
    public static void handlePdfCreate(List<Lab_Result__c> results) {
        Set<Id> resIds = new Set<Id>();
        for(Lab_Result__c r : results){
            resIds.add(r.Id);
        }
        PdfCreateClass.savePDF(resIds);
    }
}
