Ubidots <- Ubidots.Client("YOUR_TOKEN");

local VAR_LABEL  =  "humidity";

device.on("saveValue", function(value) {
    Ubidots.sendToVariable(VAR_LABEL, value);    
    server.log("Sending data to Ubidots");
    server.log(value);
});  