import { LightningElement, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import uploadCsv from "@salesforce/apex/UploadCSVHandler.uploadCsv";

export default class CommunityImportTool extends LightningElement {
  //@api RecordId;
  @api isLabResultInfo = false;
  @api isPatientInfo = false;

  get acceptedFormats() {
    return [".csv"];
  }

  handlePatientClick(){
    this.isLabResultInfo = false;
    this.isPatientInfo = !this.isPatientINfo;

  }

  handleLabResultsClick(){
    this.isPatientInfo = false;
    this.isLabResultInfo = !this.isLabResultInfo; 
  }

   async handleUploadFinished(event) {
    // Get the list of uploaded files
    const uploadedFiles = event.detail.files;
    
    try{
      await uploadCsv({ csvDocumentId: uploadedFiles[0].documentId })
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Success",
          message:
            uploadedFiles.length +
            " Files uploaded Successfully: " +
            uploadedFiles[0].name,
          variant: "success"
        })
      );
    }
    catch(err)
    {
      console.error(err);
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error",
          message: JSON.stringify(err.body.message),
          variant: 'error',
        })
      );
    }
  }
}
