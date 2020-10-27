@isTest
public with sharing class TestFactory {
 
    public static List<Lab_Result__c> generateLabResult(Integer numberOfResults){
        List<Lab_Result__c> labResults = new List<Lab_Result__c>();
        List<Contact> patients = generatePatients(numberOfResults);
        for (Contact p : patients){
            String SpecimenId =p.Specimen_ID__c;
            Lab_Result__c lr = new Lab_Result__c();
            lr.Specimen_ID__c = SpecimenId;
            lr.Results__c = 'Negative';
            lr.Patient__c = p.Id;
            labResults.add(lr);
        }
    
        insert labResults;
        return labResults;
    }
    
    public static List<Contact> generatePatients(Integer numberOfContacts){
        List<Contact> patients = new List<Contact>();
        for (Integer i = 0; i<numberOfContacts; i++ ){
            Contact c = new Contact();
            c.Account = generateAccount();
            c.LastName = 'Testing'+i;
            c.FirstName = 'Test'+i;
            c.MiddleName = 'A'+i;
            c.Birthdate = System.today();
            c.Race__c = 'Other Race';
            c.Phone = '1234567890';
            c.Sex__c = 'Female';
            c.Patient_ID__c = 'A'+i;
            c.MailingStreet = 'TestAv'+i+'23';
            c.MailingCity = 'City';
            c.MailingState = 'New York';
            c.MailingCountry = 'United States';
            c.MailingPostalCode = '12345';
            c.County__c = 'Test123';
            c.Specimen_ID__c = 'A'+i;
            c.Collect_Date__c = System.today();
            c.Collect_Time__c = System.now().time();
            c.Test_Type__c = 'Oropharyngeal';
            c.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName()
            .get('Patient_Record').getRecordTypeId();
            patients.add(c);
        }
        insert patients;
        return patients;
    }

    public static Account generateAccount(){
        Account a = new Account();
        a.Name = 'Test';
        a.BillingCountry = 'United States';
        a.Type = 'Partner';
        insert a;
        return a;
    }
}
