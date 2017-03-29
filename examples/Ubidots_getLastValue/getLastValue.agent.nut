Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "temp";

device.on("get", function(data){
    device.send("get", Ubidots.getLastValue(DEV_LABEL, VAR_LABEL));   
});