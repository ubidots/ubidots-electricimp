# Ubidots v1.0.0

The Ubidots library allows you to easily integrate your agent code with the Ubidots Platform. This library provides an easy way to to send multiple values to the Ubidots API, you just need the name and the value that you want to send. In addition you are able to get the last value from a variable of your Ubidots account.

To add this library to your project, add ```#require "Ubidots.class.nut:1.0.0"```  to the top of your agent code.

##  Class Usage 

### Constructor: Ubidots.Client(token, server)

To create a new Ubidots client assign your Ubidots' **Token** to the constructor:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN")
```

##  Class Methods 

## Ubidots.setDeviceLabel(dsLabel)

This function is to set a new device label. The library set the device ID of your imp as device label to be a unique identifier, but also you can change if you desire.

```c
Ubidots.setDeviceLabel("device_label_here")
```

### Ubidots.get(dsLabel, varLabel, callback)

This function is to get body of a variable from the Ubidots API. To be able to get the body of a variable from Ubidot you have to assign the device and variable labels. The callback function take the parameter: resp. The resp parameter is a table containing the response from the server with the  message received. 

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "device_label_here";
local VAR_LABEL  =  "var_label_here";

// e.i: {"count": 774, ... , "results": [{"value": 2.8, "timestamp":1490736636651, "context": {}}, ... ]}
Ubidots.get(DEV_LABEL, VAR_LABEL, function(v){
    server.log(v);
});
```

### Ubidots.getLastValue(dsLabel, varLabel, callback)

This function is to get the float last value of a variable from the Ubidots API. To be able to get the last value of a variable from Ubidot you have to assign the device and variable labels. The callback function take the parameter: resp. The resp parameter is a table containing the response from the server with the  message received. 


```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "device_label_here";
local VAR_LABEL  =  "variable_label_here";

// e.i: 2.8
Ubidots.getLastValue(DEV_LABEL, VAR_LABEL, function(v){
    server.log(v);
});
```

### Ubidots.sendToVariable(varLabel, data, callback = null)

This function is to send one value to a variable. To be able to send values to a variable you have to assign the variable label where you want receive the data; the value is float type. This method also optionally takes a callback that take the response. The response will always be the response object returned by httprequest.sendasync(). 


```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local VAR_LABEL  =  "test";

// sending 2.8 to Ubidots:  { "value": 2.8 }
Ubidots.sendToVariable(VAR_LABEL, 2.8); 
```


### Ubidots.sendToDevice(data, callback = null)

This function is to send multiple variables to a device. To be able to send multiple values to Ubidots you have to build a table to send it. This method also optionally takes a callback that take the response. The response will always be the response object returned by httprequest.sendasync(). 

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

data <- {};
data.temp <- 25;
data.humid <- 40;
data.pressure <- 18.13;

 // { "body": "{\"pressure\": [{\"status_code\": 201}], \"humid\": [{\"status_code\": 201}], \"temp\": [{\"status_code\": 201}]}", "statuscode": 200, ... , "allow": "POST, OPTIONS", "vary": "Accept, Cookie" ...
Ubidots.sendToDevice(data);
```

