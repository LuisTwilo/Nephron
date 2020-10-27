public with sharing class Helpers {
    
    public static List<Map<String,String>> createMapOfResultsToSerialize(List<Lab_Result__c> labResults){
        List<Map<String,String>> labResultList = new List<Map<String,String>>();
        for (Lab_Result__c lr: labResults){

            String DOB;
            String collectDate;
            String collectTime;

            if(lr.Patient__r != null){
                if( lr.Patient__r.Birthdate != null){
                DOB = lr.Patient__r.Birthdate.format();
                }
                if( lr.Collect_Date__c != null){
                    collectDate = lr.Collect_Date__c.format();
                }
                if( lr.Collect_Time__c != null){
                collectTime = String.valueOf(lr.Collect_Time__c);
                }
            }
            Map<String,String> labResultTemplate = new Map<String,String>{
                'SFPaientId' => lr.Patient__c,
                'SFAccountId' => lr.Account__c,
                'Result'=> lr.Results__c,
                'TestType' => lr.TestType__c,
                'CollectDate' => collectDate,
                'CollectTime' =>collectTime,
                'SFLabResultId' => lr.Id,
                'SpecimenId' => lr.Specimen_ID__c,
                'PatientId' => lr.Patient__r.Patient_ID__c,
                'PatientFirstName' => lr.Patient__r.FirstName,
                'PatientMiddleName' => lr.Patient__r.MiddleName,
                'PatientLastName' => lr.Patient__r.LastName,
                'DOB' => DOB,
                'Sex' => lr.Patient__r.Sex__c,
                'Race' => lr.Patient__r.Race__c,
                'PatientAddress2' => lr.Patient__r.Address_2__c,
                'PatientAddress' => lr.Patient__r.MailingStreet,
                'PatientAddressCity' => lr.Patient__r.MailingCity,
                'PatientAddressState' => lr.Patient__r.MailingState,
                'PatientAddressZip' => lr.Patient__r.MailingPostalCode,
                'PatientAddressCounty' => lr.Patient__r.County__c,
                'PatientPhone' => lr.Patient__r.Phone,
                'OrderingFacilityName' => lr.Account__r.Name,
                'OrderingFacilityPhone' => lr.Account__r.Phone,
                'OrderingFacilityAddress' => lr.Account__r.BillingStreet,
                'OrderingFacilityAddressCity' => lr.Account__r.BillingCity,
                'OrderingFacilityAddressState' => lr.Account__r.BillingState,
                'OrderingFacilityAddressZip' => lr.Account__r.BillingPostalCode,
                'OrderingFacilityAdreesCountry' => lr.Account__r.BillingCountry,
                'IsFirstTest' => lr.Patient__r.First_test__c,
                'IsPatientEmployeedInHealthcare' => lr.Patient__r.Employed_in_healthcare__c,
                'SymptomaticAsDefinedByCDC' => lr.Patient__r.Symptomatic_as_defined_by_CDC__c,
                'Hospitalized' => lr.Patient__r.Hospitalized__c,
                'ICU' => lr.Patient__r.ICU__c,
                'ResidentInACongregateCareSetting' => lr.Patient__r.Resident_in_a_congregate_care_setting__c,
                'Pregnant' => lr.Patient__r.Pregnant__c,
                'ResultDatetime' => lr.CreatedDate.format('yyyy-MM-dd h:mm')
            }; 
            labResultList.add(labResultTemplate);       
        }
        return labResultList;
    }

    public static List<Map<String,String>> createMapOfPatientsToSerialize(List<Contact> patients){
        List<Map<String, String>> patientList = new List<Map<String, String>>();
        for(Contact c : patients){
            String DateOnSymptom;
            String collectDate;
            String collectTime;

            if( c.Date_of_Symptom_Onset__c != null){
                DateOnSymptom = c.Date_of_Symptom_Onset__c.format();
            }
            if(c.Collect_Date__c != null){
                collectDate = c.Collect_Date__c.format();
            }
            if(c.Collect_Time__c != null){
                collectTime = String.valueOf(c.Collect_Time__c);
            }
    
            Map<String,String> patient = new Map<String,String>{
                'FirstName' => c.FirstName,
                'MiddleName' => c.MiddleName,
                'LastName' => c.LastName,
                'Phone' => c.Phone,
                'Country' => c.MailingCountry,
                'State' => c.MailingState,
                'City' => c.MailingCity,
                'Address' => c.MailingStreet,
                'Address2' => c.Address_2__c,
                'County' => c.County__c,
                'PostalCode' => c.MailingPostalCode,
                'Race' => c.Race__c,
                'Sex' => c.Sex__c,
                'PatientId' => c.Patient_ID__c,
                'SpecimenId' => c.Specimen_ID__c,
                'Pregnant' => c.Pregnant__c,
                'EmployedInHealthcare' => c.Employed_in_healthcare__c,
                'SymptomaticAsDefinedByCDC' => c.Symptomatic_as_defined_by_CDC__c,
                'Hospitalized' => c.Hospitalized__c,
                'ICU' => c.ICU__c,
                'ResidentInACongregateCareSetting' => c.Resident_in_a_congregate_care_setting__c,
                'Date of Symptom Onset' => DateOnSymptom,
                'CollectDate' => collectDate,
                'CollectTime' => collectTime,
                'TestType' => c.Test_Type__c,
                'OrderingFacilityName' => c.Account.Name,
                'OrderingFacilityPhone' => c.Account.Phone,
                'OrderingFacilityAddress' => c.Account.BillingStreet,
                'OrderingFacilityAddressCity' => c.Account.BillingCity,
                'OrderingFacilityAddressState' => c.Account.BillingState,
                'OrderingFacilityAddressZip' => c.Account.BillingPostalCode,
                'OrderingFacilityAdreesCountry' => c.Account.BillingCountry
            };
            patientList.add(patient);
        }
        return patientList;
    }

}
