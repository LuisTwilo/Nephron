public with sharing class TestingStuff {
    public static void testing(Datetime dateJ,String incremental, String incrementalCommit, String query ){
        List<Lab_Result__c> results = new List<Lab_Result__c>();
        String finalQuery;
        
        if (dateJ != null){
            Datetime lastTime = dateJ.addHours(24);
            APIJobs__c lastJobOfGivenDate = [SELECT Id, JobDateTime__c FROM APIJobs__c WHERE CreatedDate >: dateJ 
            AND CreatedDate <: lastTime ORDER BY CreatedDate DESC LIMIT 1];

            Datetime lastJob = lastJobOfGivenDate.JobDateTime__c;
            if(lastJobOfDay != null){
                finalQuery = 'lastJob AND LastModifiedDate <: lastTime ';
            }



        }
    }
}
