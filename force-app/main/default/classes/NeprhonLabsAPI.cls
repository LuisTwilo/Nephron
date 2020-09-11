/* 
  -- +===================================================================+
  -- +                           Nephron Labs                             |
  -- +===================================================================+
  -- |                                                                    |
  -- |Author: Twilo.ai                                                    |
  -- |Initial Build Date:  08/24/2020                                     |
  -- |Source File Name: NeprhonLabsAPI.apxc                               |
     |                                                                    |
  -- |                                                                    |
  -- |Description: This APi allows the users to submit lab results        |
  -- |             and patient information, also, allows the user to get  |
  -- |             lab results and patient information on demand.         |
  -- |                                                                    |
  -- |Modification History:                                               |
  -- |=====================                                               |
  -- |Version     Date           Author       Remarks                     |
  -- |=========   ============  =========    ===========================  |
  -- |1.0         08/24/2020    Londono L    Initial version              |
  -- |                                                                    |
  -- +===================================================================+
  */

@RestResource(urlMapping='/Nephron/*')
global with sharing class NeprhonLabsAPI {

    @HttpGet
    global static void getData() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        response.headers.put('Content-Type', 'application/json');
        LastJobDate__c lastJob = LastJobDate__c.getOrgDefaults();
        Datetime lastJobDate = lastJob.LastJob__c;
        String recordType = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1); 
        System.debug('--------'+RecordType);

        if(recordType.contains('labResults')){
            List<Lab_Result__c> labResultsOnJob =  new List<Lab_Result__c>();
            List<Map<String,String>> results =  new List<Map<String,String>>();
            Map<String, String> params = request.params;
            Datetime initialTime;
            Datetime finalTime;
            Datetime now = System.now();
            
            
            if(params.get('date') != null) {
                initialTime = date.valueOf(params.get('date'));
                finalTime = initialTime.addHours(24);
            }     
            String incremental = params.get('incremental');
            String incrementalCommit = params.get('incrementalCommit');

            response.statusCode = 200;  

            String query = 'SELECT Patient__r.FirstName, Patient__r.MiddleName,  Patient__r.LastName, Patient__r.Birthdate,'+
            'Patient__r.Phone, Patient__r.Race__c, Patient__r.Sex__c, Patient__r.MailingCity,'+ 
            'Patient__r.MailingCountry, Patient__r.MailingState, Patient__r.MailingStreet,Patient__r.Address_2__c,'+
            'Patient__r.MailingPostalCode, Patient__r.County__c, Account__r.Name, Account__r.BillingCity,'+
            'Account__r.BillingCountry, Account__r.BillingState, Account__r.BillingStreet,'+
            'Account__r.BillingPostalCode, Account__r.Phone, Patient__r.Patient_ID__c, TestType__c,'+
            'Patient__r.First_test__c,  Patient__r.Employed_in_healthcare__c, Patient__r.Symptomatic_as_defined_by_CDC__c,'+
            'Patient__r.Hospitalized__c, Patient__r.ICU__c, Patient__r.Resident_in_a_congregate_care_setting__c,'+
            'Patient__r.Pregnant__c, Patient__r.Specimen_ID__c, Results__c, Collect_Date__c, Collect_Time__c, CreatedDate '+    
            'FROM Lab_Result__c WHERE LastModifiedDate >: ';

            String finalQuery = 'initialTime AND  LastModifiedDate <: finalTime ';

            if(params.size() >= 1){
                if(initialTime != null && (incremental != 'y' )){
                    query += finalQuery;
                    results = Helpers.createMapOfResultsToSerialize(database.query(query));
                    if(results.size() == 0){
                        response.statusCode = 404;
                    }                            
                }else{
                    if(incremental == 'y'){
                        finalQuery = 'lastJobDate AND  LastModifiedDate <: now';
                        query += finalQuery;
                        results = Helpers.createMapOfResultsToSerialize(database.query(query)); 
                        if(results.size() == 0){
                            response.statusCode = 404;
                        }               
                    }else{
                      response.statusCode = 400;
                    }
                }   
            }else{
               response.statusCode = 400;
            }

            if(incrementalCommit == 'y'){  
                    lastJob.LastJob__c = System.now();
                    update lastJob;         
            }
            response.responseBody = Blob.valueOf(JSON.serialize(results));
        }
        else{
            if(recordType.contains('patients')){
                Map<String, String> params = request.params;
                List<Map<String,String>> patients = new List<Map<String,String>>();
                Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName()
                .get('Patient_Record').getRecordTypeId();
                Date collectionDate;
                if(params.get('collectDate') != null){
                   collectionDate =  Date.valueOf(params.get('collectDate'));
                }

                String accountId = params.get('accountId');
                Date finalDate;

                String query = 'SELECT LastName, MiddleName, FirstName, Phone, MailingCountry, MailingState,Address_2__c, MailingCity,'+
                'MailingStreet, MailingPostalCode, County__c, Race__c, Sex__c, Patient_ID__c, Specimen_ID__c, Pregnant__c,'+
                'Employed_in_healthcare__c, Symptomatic_as_defined_by_CDC__c, Medical_Release_Received__c, Hospitalized__c,'+
                'ICU__c, Resident_in_a_congregate_care_setting__c, Date_of_Symptom_Onset__c, Collect_Date__c, Collect_Time__c,'+
                'Test_Type__c, Account.Name, Account.BillingCountry, Account.BillingState, Account.BillingCity,'+
                'Account.BillingStreet, Account.BillingPostalCode, Account.Phone FROM Contact WHERE RecordTypeId =: recordTypeId ';

                String finalQuery;

                if(collectionDate != null && accountId !=null){
                    finalDate = collectionDate.addDays(1);
                    finalQuery = 'AND Collect_Date__c >=: collectionDate AND Collect_Date__c <: finalDate '+
                    'AND AccountId =: accountId';
                    query+=finalQuery;
                    patients = Helpers.createMapOfPatientsToSerialize(Database.query(query));
                    response.responseBody = Blob.valueOf(JSON.serialize(patients));
                    response.statusCode = 200;
                }else{
                    if(collectionDate != null){
                        finalDate = collectionDate.addDays(1);
                        finalQuery = 'AND Collect_Date__c >=: collectionDate AND Collect_Date__c <: finalDate';
                        query+=finalQuery;
                        patients = Helpers.createMapOfPatientsToSerialize(Database.query(query));
                        response.responseBody = Blob.valueOf(JSON.serialize(patients));
                        response.statusCode = 200;
                    }else{
                        if(accountId !=null){
                            finalQuery = 'AND AccountId =: accountId';
                            query+=finalQuery;
                            patients = Helpers.createMapOfPatientsToSerialize(Database.query(query));
                            response.responseBody = Blob.valueOf(JSON.serialize(patients));
                            response.statusCode = 200;
                        }else{
                            response.statusCode = 400;
                        }
                    }
                }
            }else{
                response.statusCode = 400;
            }
        }  
    }

    @HttpPost
    global static void upsertData(){
        
        RestRequest request = RestContext.request; 
        RestResponse response = RestContext.response;
        response.headers.put('Content-Type', 'application/json');

        String recordType = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1); 
        List<SObject> requestBodyInfo = new List<SObject>();
        List<SObject> dataToInsert = new List <SObject>();
         
        if(recordType == 'labResults'){
            requestBodyInfo = (List<Lab_Result__c>)
            JSON.deserialize(request.requestBody.toString(), List<Lab_Result__c>.class);  
            Schema.SObjectField fToken = Lab_Result__c.Fields.Id;

            for(Lab_Result__c lr: (List<Lab_Result__c>)requestBodyInfo){
                Contact patient = new Contact(Specimen_ID__c = lr.Specimen_ID__c);
                lr.Patient__r = patient;
                dataToInsert.add(lr);
            }

            Database.UpsertResult[] LabsResultdsUpserted = Database.upsert(dataToInsert,fToken, false); 
            response.responseBody = Blob.valueOf(JSON.serialize(LabsResultdsUpserted));
        }  
           
        if(recordType == 'patients'){
            requestBodyInfo = (List<Contact>)
            JSON.deserialize(request.requestBody.toString(), List<Contact>.class);
            Schema.SObjectField fToken = Contact.Fields.Specimen_ID__c;
            Id RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName()
            .get('Patient_Record').getRecordTypeId();

            for (Contact con : (List<Contact>)requestBodyInfo) {
               con.RecordTypeId = RecordTypeId;
               dataToInsert.add(con); 
            }  

            Database.UpsertResult[] patientsUpserted = Database.upsert(dataToInsert, fToken, false); 
            response.responseBody = Blob.valueOf(JSON.serialize(patientsUpserted));          
        }
    }
}
