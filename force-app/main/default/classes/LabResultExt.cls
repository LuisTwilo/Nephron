public with sharing class LabResultExt {
    public List<Lab_Result__c> labResultsList {get;set;}
    private ApexPages.StandardSetController standardController;
    private Set<Id> labResultIds = new Set<Id>();

    public LabResultExt(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        labResultsList = new List<Lab_Result__c>();
        for (Lab_Result__c labR : (List<Lab_Result__c>)standardController.getSelected()){ 
            labResultIds.add(labR.Id);
            System.debug(labR.Id);
        }
        labResultsList = [SELECT Name, FirstName__c, MInitial__c,  LastName__c, Collect_Date__c,
        Collect_Time__c, DOBirth__c, Employee_ID__c, Results__c FROM Lab_Result__c WHERE Id IN: labResultIds];
    }
}