#require "Ubidots.agent.lib.nut:1.0.0"

Ubidots <- Ubidots.Client("YOUR_TOKEN");

local VAR_LABEL  =  "test";
local TIMESTAMP = 1490226587;


device.on("saveValue", function(value) {
    Ubidots.sendToVariable(VAR_LABEL, {"value": value, "timestamp": TIMESTAMP +"000"});
    server.log("Sending data to Ubidots");
    TIMESTAMP = TIMESTAMP + 1;
});
