Ubidots <- Ubidots.Client("YOUR_TOKEN");

//Ubidots.setDeviceName("electric-imp"); // to set the device name

device.on("saveValue", function(data){
    
    Ubidots.sendToDevice(data);
    server.log("Sending data to Ubidots");
    server.log(http.jsonencode(data));
});