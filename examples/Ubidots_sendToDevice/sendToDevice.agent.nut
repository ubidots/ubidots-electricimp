Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";

device.on("saveValue", function(data){
    
    Ubidots.sendToDevice(DEV_LABEL, data);
    server.log("Sending data to Ubidots");
    server.log(http.jsonencode(data));
});