public with sharing class LabResultsImportController {
    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public List<Lab_Result__c> labResultslist{get;set;}
 
    public LabResultsImportController() {
        csvFileLines = new String[]{};
        labResultslist = New List<Lab_Result__c>(); 
    }

    public void importCSVFile(){
        try{
            csvAsString = csvFileBody.toString();
            csvFileLines = csvAsString.split('\n'); 
             
            for(Integer i=1;i<csvFileLines.size();i++){
                Lab_Result__c lr = new Lab_Result__c() ;
                string[] csvRecordData = csvFileLines[i].split(',');
               
                lr.Account__c = csvRecordData[0] ;  
                Contact contactReference = new Contact(Specimen_ID__c = csvRecordData[1]);           
                lr.Patient__r = contactReference;
                lr.Results__c = csvRecordData[2];
                lr.Specimen_ID__c = csvRecordData[3];                                                                                
                
                labResultslist.add(lr);   
            }
            if(!labResultslist.isEmpty()){
                insert labResultslist;
            }   
        
         }
         catch (Exception e)
         {
             ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
             ApexPages.addMessage(errorMessage);
         }  
   }

}
