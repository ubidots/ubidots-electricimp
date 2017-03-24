Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";
local TIMESTAMP = 1490226587;


device.on("saveValue", function(value) {
    Ubidots.sendValues(DEV_LABEL, VAR_LABEL, {"value": value, "timestamp": TIMESTAMP +"000"});
    server.log("Sending data to Ubidots");
    server.log(value);
    TIMESTAMP = TIMESTAMP + 1;
}); 
