@isTest
public with sharing class PdfGenerationTest {
    @isTest
    public static void testingPdfGeneration() {
        List<Lab_Result__c> results = new List<Lab_Result__c>();
        Set<Id> resIds = new Set<Id>();
        for(Integer i = 0; i<2; i++){
            Lab_Result__c r = new Lab_Result__c();
            r.Patient__c = '0030v00000RvJeAAAV';
            r.Account__c = '0010v00000XYPz5AAH';
            r.Results__c = 'positive';
            results.add(r);
        }
        insert results;

        for (Lab_Result__c res: results){
            resIds.add(res.Id);
        }
        
        System.Test.startTest();
        PdfCreateClass.savePDF(resIds);
        System.Test.stopTest();
    }
}
