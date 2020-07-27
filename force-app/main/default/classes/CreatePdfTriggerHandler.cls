/*  -- +===================================================================+
  -- +                           Nephron Labs
  -- +===================================================================+
  -- |                                                                    |
  -- |Author: Luis Londono                                                |
  -- |Initial Build Date:  7/20/2020                                      |
  -- |Source File Name: CreatePdfTriggerHandler.apxc                      |
     |                                                                    |
  -- |                                                                    |
  -- |                                                                    |
  -- |Description: handles the trigger information and send it to the     |
  -- |create pdf method                                                   |
  -- |                                                                    |
  -- |Modification History:                                               |
  -- |=====================                                               |
  -- |Version     Date           Author       Remarks                     |
  -- |=========   ============  =========    ===========================  |
  -- |1.0          7/20/2020     Londono L    Initial draft version       |
  -- +===================================================================+
  */


public with sharing class CreatePdfTriggerHandler {
    public static void handlePdfCreate(Map<Id,Lab_Result__c> results) {
        Set<Id> resIds = new Set<Id>();
        resIds = results.keySet();
        if(!System.isFuture()){
          PdfCreateClass.savePDF(resIds);
        }
    }
}
