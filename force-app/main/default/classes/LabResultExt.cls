/* 
  -- +===================================================================+
  -- +                           Nephron Labs
  -- +===================================================================+
  -- |                                                                    |
  -- |Author: Twilo.ai                                               |
  -- |Initial Build Date:  7/15/2020                                      |
  -- |Source File Name: LabResultExt.apxc                                 |
     |                                                                    |
  -- |                                                                    |
  -- |                                                                    |
  -- |Description: controller extension to get the data for excel page    |
  -- |                                                                    |
  -- |Modification History:                                               |
  -- |=====================                                               |
  -- |Version     Date           Author       Remarks                     |
  -- |=========   ============  =========    ===========================  |
  -- |1.0          7/15/2020     Londono L    Initial draft version       |
  -- |1.1          8/12/2020     Londono L    adding fields to the query  |
  -- +===================================================================+
  */


public with sharing class LabResultExt {
    public List<Lab_Result__c> labResultsList {get;set;}
    private ApexPages.StandardSetController standardController;
    private Set<Id> labResultIds = new Set<Id>();

    public LabResultExt(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        labResultsList = new List<Lab_Result__c>();
        for (Lab_Result__c labR : (List<Lab_Result__c>)standardController.getSelected()){ 
            labResultIds.add(labR.Id);
        }
        labResultsList = [SELECT FirstName__c, MInitial__c,  LastName__c, DOBirth__c,
        Patient__r.Phone, Patient__r.Race__c, Patient__r.Sex__c, Patient__r.MailingCity, 
        Patient__r.MailingCountry, Patient__r.MailingState, Patient__r.MailingStreet,
        Patient__r.MailingPostalCode, Patient__r.County__c, Account__r.Name, Account__r.BillingCity,
        Account__r.BillingCountry, Account__r.BillingState, Account__r.BillingStreet,
        Account__r.BillingPostalCode,Patient__r.Patient_ID__c,
        Patient__r.First_test__c,  Patient__r.Employed_in_healthcare__c, Patient__r.Symptomatic_as_defined_by_CDC__c,
        Patient__r.Hospitalized__c, Patient__r.ICU__c, Patient__r.Resident_in_a_congregate_care_setting__c,
        Patient__r.Pregnant__c, Patient__r.Specimen_ID__c, Results__c, Collect_Date__c, Collect_Time__c 
        FROM Lab_Result__c WHERE Id IN: labResultIds];
    }
}