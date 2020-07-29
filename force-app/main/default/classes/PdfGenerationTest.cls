@isTest
public with sharing class PdfGenerationTest {
    @isTest
    public static void testingPdfGeneration() {
        List<Lab_Result__c> results = new List<Lab_Result__c>();
        Set<Id> resIds = new Set<Id>();
        for(Integer i = 0; i<2; i++){
            Lab_Result__c r = new Lab_Result__c();
            r.Patient__c = '0036g00000WWMhRAAX' ;//'0036g00000WWMhRAAX';
            r.Account__c = '0016g00000OyeNvAAJ';//'0016g00000LjtcSAAR';
            r.Results__c = 'positive';
            r.Specimen_ID__c = '21312';
            r.isDocumented__c = false;
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
