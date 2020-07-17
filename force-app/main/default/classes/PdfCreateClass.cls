public with sharing class PdfCreateClass {
    //@auraEnabled
    @Future(callout=true)
    public static void savePDF(Set<Id> records){
        List<Attachment> attachments = new List<Attachment>();
        for(Id rId: records){
            PageReference pdfPage = new PageReference('/apex/PdfPage');
            pdfPage.getParameters().put('Id', rId);
           Blob pdfContent;
            if(Test.isRunningTest()){
                pdfContent = blob.valueOf('Unit.Test');
            }else{
                pdfContent = pdfPage.getContent();
            }
            
            Attachment attach1= new Attachment();
            attach1.ParentId = rId;
            attach1.Name = 'Test Results';
            attach1.Body = pdfContent;
            attach1.contentType = 'application/pdf';
            attachments.add(attach1);
        }
        insert attachments;          
    }
}

