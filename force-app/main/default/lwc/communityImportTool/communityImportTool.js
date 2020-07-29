import { LightningElement, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import uploadCsv from "@salesforce/apex/UploadCSVHandler.uploadCsv";

export default class CommunityImportTool extends LightningElement {
  //@api RecordId;
  @api isLabResultInfo = false;
  @api isPatientINfo = false;

  get acceptedFormats() {
    return [".csv"];
  }

  handlePatientClick(){
    console.log("patient info button clicked")
  }

  handleLabResultsClick(){
    this.isLabResultInfo = this.isLabResultInfo ? false : true;
  }

  handleUploadFinished(event) {
    // Get the list of uploaded files
    const uploadedFiles = event.detail.files;
    console.log('inside upload finished');
    uploadCsv({ csvDocumentId: uploadedFiles[0].documentId })
      .then(() => {
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
      })
      .catch((error) => {
        this.dispatchEvent(
            new ShowToastEvent({
              title: "Error",
              message: JSON.stringify(error),
              variant: 'error',
            })
          );
      });
  }
}
