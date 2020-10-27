@isTest
public with sharing class NephronCustomAPITest {
    private static String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
    private static String serviceURL = '/services/apexrest/Nephron';

    private static String LabResultsJSONRequest = '['+
    '{'+
       ' "Specimen_ID__c ":"A1",'+
       ' "Results__c":"Negative"'+
    '},'+
    '{'+
    ' "Specimen_ID__c ":"A2",'+
    ' "Results__c":"Negative"'+
    '}'+
    ']';

    private static String patientJSONRequest = '['+
       ' {'+
       '    "AccountId":"0016g00000AZkUpAAL",'+
       '    "LastName":"Londono",'+ 
       '    "MiddleName":"Al",'+
       '    "FirstName":"Luis", '+
       '    "Birthdate":"1992-04-11",'+
       '    "Race__c":"White",'+
       '    "First_test__c":"",'+
       '    "Phone":"1234567890",'+
       '    "Sex__c":"Male",'+
       '    "Medical_Release_Received__c":"",'+
       '    "Photo_ID_Verified__c":"",'+
       '    "Patient_ID__c":"123456789",'+
       '    "Opt_in_Opt_Out__c":"",'+
       '    "MailingStreet":"Test Av 123",  '+
       '    "MailingCity":"New York",'+
       '    "MailingState":"New York", '+   
       '    "MailingPostalCode":"",'+
       '    "County__c":"Brooklyn",'+
       '    "MailingCountry":"United States", '+
       '    "Specimen_ID__c":"123456789",'+
       '    "Collect_Date__c":"2020-08-26",'+
       '    "Time Collect_Time__c":"10:34:24.000Z",'+
       '    "Test_Type__c":"Oropharyngeal",'+
       '    "Status__c":"",'+
       '    "Type_of_Payment__c":"",'+
       '    "Payment__c":"",'+
       '    "Amount__c":"",'+
       '    "Employed_in_healthcare__c":"No",'+
       '    "Symptomatic_as_defined_by_CDC__c":"Yes",'+
       '    "Hospitalized__c":"No",'+
       '    "ICU__c":"No",'+
       '    "Resident_in_a_congregate_care_setting__c":"No",'+
       '    "Pregnant__c":"No",'+
       '    "Date_of_Symptom_Onset__c":"2020-08-15",'+
       '    "Lab_result_exists__c":"",'+
       '    "Contacted_Patient__c":"",'+
       '    "Patient_Contacted__c":""'+
       '}, '+
       '{'+
       '    "AccountId":"0016g00000AZkUpAAL",'+
       '    "LastName":"Londono", '+
       '    "MiddleName":"F",'+
       '    "FirstName":"Juan",'+ 
       '    "Birthdate":"1994-02-08",'+
       '    "Race__c":"White",'+
       '    "First_test__c":"",'+
       '    "Phone":"1234567890",'+
       '    "Sex__c":"Male",'+
       '    "Medical_Release_Received__c":"",'+
       '    "Photo_ID_Verified__c":"",'+
       '    "Patient_ID__c":"abc12345",'+
       '    "Opt_in_Opt_Out__c":"",'+
       '    "MailingStreet":"Test Av 123",'+  
       '    "MailingCity":"New York",'+
       '    "MailingState":"New York", '+   
       '    "MailingPostalCode":"",'+
       '    "County__c":"Brooklyn",'+
       '    "MailingCountry":"United States", '+
       '    "Specimen_ID__c":"2020082412345",'+
       '    "Collect_Date__c":"2020-08-26",'+
       '    "Time Collect_Time__c":"10:34:24.000Z",'+
       '    "Test_Type__c":"PCR",'+
       '    "Status__c":"",'+
       '    "Type_of_Payment__c":"",'+
       '    "Payment__c":"",'+
       '    "Amount__c":"",'+
       '    "Employed_in_healthcare__c":"No",'+
       '    "Symptomatic_as_defined_by_CDC__c":"Yes",'+
       '    "Hospitalized__c":"No",'+
       '    "ICU__c":"No",'+
       '    "Resident_in_a_congregate_care_setting__c":"No",'+
       '    "Pregnant__c":"No",'+
       '    "Date_of_Symptom_Onset__c":"2020-08-15",'+
       '    "Lab_result_exists__c":"",'+
       '    "Contacted_Patient__c":"",'+
       '    "Patient_Contacted__c":""'+
       '}'+
   ']';
    
   
   @isTest(SeeAllData=true)
    public static void testGetLabResulstHappyPath(){
        List<Lab_Result__c> createdResults = TestFactory.generateLabResult(5);
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        response.statusCode = 200;
        request.params.put('date', '2020-10-09');
        request.params.put('incremental', 'n');
        request.params.put('incrementalCommit', 'y');
        request.requestURI = baseUrl+serviceURL+'/labResults';
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = response;
        NeprhonLabsAPI.getData();
        
    }

    @isTest(SeeAllData=true)
    public static void testGetLabResulsIncremental(){
        List<Lab_Result__c> createdResults = TestFactory.generateLabResult(5);
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        response.statusCode = 200;
        request.params.put('date', '2020-10-09');
        request.params.put('incremental', 'y');
        request.params.put('incrementalCommit', 'y');
        request.requestURI = baseUrl+serviceURL+'/labResults';
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = response;
        NeprhonLabsAPI.getData();
    }

    @isTest
    public static void testGetPatientsInfoByDate(){
        List<Contact> contacts = TestFactory.generatePatients(5);
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        response.statusCode = 200;
        request.params.put('collectDate', '2020-10-09');
        request.requestURI = baseUrl+serviceURL+'/patients';
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = response;
        NeprhonLabsAPI.getData();
    }

    @isTest
    public static void testGetPatientsInfoByAccountAndDate(){
        List<Contact> contacts = TestFactory.generatePatients(5);
        Id accId = contacts[0].AccountId;
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        response.statusCode = 200;
        request.params.put('collectDate', '2020-10-09');
        request.params.put('accountId', 'abc123');
        request.requestURI = baseUrl+serviceURL+'/patients';
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = response;
        NeprhonLabsAPI.getData();
    }

    @isTest
    public static void testGetPatientsInfoByAccount(){
        List<Contact> contacts = TestFactory.generatePatients(5);
        Id accId = contacts[0].AccountId;
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        response.statusCode = 200;
        request.params.put('accountId', 'abc123');
        request.requestURI = baseUrl+serviceURL+'/patients';
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = response;
        NeprhonLabsAPI.getData();
    }

    @isTest
    public static void testLabResultInsert(){
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestBody = Blob.valueOf(LabResultsJSONRequest);
        request.headers.put('Content-Type', 'application/json');
        request.httpMethod = 'POST';
        request.requestURI = baseUrl+serviceURL+'/labResults';
        response.statusCode = 201;
        RestContext.request = request;
        RestContext.response = response;

        NeprhonLabsAPI.upsertData();
    }

    @isTest
    public static void testPatientInsert(){
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestBody = Blob.valueOf(patientJSONRequest);
        request.headers.put('Content-Type', 'application/json');
        request.httpMethod = 'POST';
        request.requestURI = baseUrl+serviceURL+'/patients';
        response.statusCode = 201;
        RestContext.request = request;
        RestContext.response = response;
        NeprhonLabsAPI.upsertData();
    }
}
