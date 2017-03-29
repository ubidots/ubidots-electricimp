Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";

device.on("saveValue", function(value) {
    Ubidots.sendToVariable(DEV_LABEL, VAR_LABEL, value);    
    server.log("Sending data to Ubidots");
    server.log(value);
});  