({
    save: function (component) {
        console.log("inside controller");
        var action = component.get("c.savePDF");
        action.setParams({
          recordId: component.get("v.pageReference").state.c__Id
        });
        action.setCallback(this, function (response) {
          var state = response.getState();
          if (state === "SUCCESS") {
            alert("Attachment saved successfully");
            var navEvt = $A.get("e.force:navigateToSObject");
            
          } else if (state === "INCOMPLETE") {
            // do something
          } else if (state === "ERROR") {
            var errors = response.getError();
            if (errors) {
              if (errors[0] && errors[0].message) {
                console.log("Error message: " + errors[0].message);
              }
            } else {
              console.log("Unknown error");
            }
          }
        });
        $A.enqueueAction(action);
        
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
          "recordId": component.get("v.pageReference").state.c__Id,
          "slideDevName": "details"
        });
        navEvt.fire();
      },
    
      cancel:  function (component){
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
          "recordId": component.get("v.pageReference").state.c__Id,
          "slideDevName": "details"
        });
        navEvt.fire();
    }
})
