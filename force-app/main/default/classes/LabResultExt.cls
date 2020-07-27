/* 
  -- +===================================================================+
  -- +                           Nephron Labs
  -- +===================================================================+
  -- |                                                                    |
  -- |Author: Luis Londono                                                |
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
        Patient__r.Phone,  Patient__r.Sex__c, Patient__r.MailingCity, 
        Patient__r.MailingCountry, Patient__r.MailingState, Patient__r.MailingStreet,
        Patient__r.MailingPostalCode, Patient__r.County__c,  TypeLabel__c, Results__c, Collect_Date__c, Collect_Time__c 
        FROM Lab_Result__c WHERE Id IN: labResultIds];
    }
}