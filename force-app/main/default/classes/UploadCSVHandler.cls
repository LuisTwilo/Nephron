public with sharing class UploadCSVHandler {
    @AuraEnabled
    public static void uploadCsv(Id csvDocumentId) {
        List<Lab_Result__c> labResultsToInsert = new List<Lab_Result__c>();
        if(csvDocumentId != null){
            ContentVersion objVersion = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:csvDocumentId];
            List<String> csvLines = objVersion.VersionData.toString().split('\n');
            for(Integer i = 1; i < csvLines.size(); i++){
                Lab_Result__c lr = new Lab_Result__c();
                list<String> csvData = csvLines[i].split(',');
                System.debug('csvRowData====> '+csvData);
                lr.Account__c = csvData[0]; // Account
                Contact referenceContact = new Contact(Specimen_ID__c = csvData[1]);
                lr.Patient__r = referenceContact; // patient reference assigned
                lr.Results__c = csvData[2]; // Results
                lr.Specimen_ID__c = csvData[3] ; // Specimen Id
                labResultsToInsert.add(lr);
            }
            try{    
                if(!labResultsToInsert.isEmpty()){
                    insert labResultsToInsert; 
                }
            }
            catch (Exception ex) {
                throw new AuraHandledException(ex.getMessage());
            } 
            
        }
            
    }
        
    
/*
    @AuraEnabled
    public static Boolean validateCSV(Id csvDocumentId){
        ContentVersion objVersion = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:csvDocumentId];
        List<String> csvLines = objVersion.VersionData.toString().split('\n');
        list<String> cols = csvLines[0].split(',');
        if(cols.size() != 5){
            return false;
        }
        else{ 
            if(cols[0] != 'Name'){
            return false;
            }
        } 
        return true;
    }
    */
}
