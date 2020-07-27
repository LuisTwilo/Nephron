/*  -- +===================================================================+
  -- +                           Nephron Labs
  -- +===================================================================+
  -- |                                                                    |
  -- |Author: Luis Londono                                                |
  -- |Initial Build Date:  7/20/2020                                      |
  -- |Source File Name: PdfCreateClass.apxc                               |
     |                                                                    |
  -- |                                                                    |
  -- |                                                                    |
  -- |Description: Creates an attached file to the lab results record     |
  -- |                                                                    |
  -- |Modification History:                                               |
  -- |=====================                                               |
  -- |Version     Date           Author       Remarks                     |
  -- |=========   ============  =========    ===========================  |
  -- |1.0          7/20/2020     Londono L    Initial draft version       |
  -- +===================================================================+
  */

public with sharing class PdfCreateClass {
    @Future(callout=true)
    public static void savePDF(Set<Id> records){
        Map<Id, Lab_Result__c> newResults = new Map<Id, Lab_Result__c>([SELECT Id, FirstName__c, LastName__c, isDocumented__c, Results__c  FROM Lab_Result__c WHERE Id IN : records ]) ;
        List<Lab_Result__c> updatedLabRes = new List<Lab_Result__c>();
        List<Attachment> attachments = new List<Attachment>();
        for(Id rId: records){
            if(!(newResults.get(rId).isDocumented__c) && newResults.get(rId).Results__c != 'Inconclusive' ){
                PageReference pdfPage = new PageReference('/apex/PdfPage');
                pdfPage.getParameters().put('Id', rId);
                Blob pdfContent;
                if(Test.isRunningTest()){
                    pdfContent = blob.valueOf('Unit.Test');
                }
                else{
                    pdfContent = pdfPage.getContent();
                }
                

                Attachment attach1= new Attachment();
                attach1.ParentId = rId;
                attach1.Name = 'Test Results '+newResults.get(rId).FirstName__c+' '+newResults.get(rId).LastName__c;
                attach1.Body = pdfContent;
                attach1.contentType = 'application/pdf';
                attachments.add(attach1);
                
                Lab_Result__c lr = new Lab_Result__c();
                lr.Id = rId;
                lr.isDocumented__c = true;
                updatedLabRes.add(lr);
                
                }   
        }
        if(attachments.size() > 0){
            insert attachments;
            update updatedLabRes; 
        }
        
                 
    }
}

