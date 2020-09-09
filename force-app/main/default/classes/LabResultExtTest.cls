@isTest
public with sharing class LabResultExtTest {  
    public static List<Lab_Result__c> labRes;
    public static Lab_Result__c labR;

    @isTest 
    public static void testMyController() {
        labRes = new List<Lab_Result__c>();
        labR =  new Lab_Result__c(
            Patient__c = '0036g00000YckLHAAZ', //'0036g00000WWMhRAAX',
            Account__c = '0016g00000XIWpSAAX', //'0016g00000LjtcSAAR',
            Results__c = 'Negative',
            Specimen_ID__c = '20200003243'
            );
       
        labRes.add(labR); 
        insert labRes;
    
        Test.startTest();
        Test.setCurrentPage(Page.ExportCSVPage);
        ApexPages.StandardSetController labResultController = new ApexPages.StandardSetController(labRes);
        labResultController.setSelected(labRes);
        LabResultExt ext = new LabResultExt(labResultController);
        Test.stopTest();
    }

}