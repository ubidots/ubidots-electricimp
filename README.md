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

## Ubidots.setDeviceName(dsName)

This function is to to set you data source name. The library set the device ID of your imp as device label to be a unique identifier, also you can change if you desire.

```c
Ubidots.setDeviceName("device_name_here")
```

### Ubidots.get(dsLabel, varLabel)

This function is to get body of a variable from the Ubidots API. Assign the device and variable labels from Ubidots:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "device_label_here";
local VAR_LABEL  =  "var_label_here";

// e.i: {"count": 774, ... , "results": [{"value": 2.8, "timestamp":1490736636651, "context": {}}, ... ]}
Ubidots.get(DEV_LABEL, VAR_LABEL);
```

To be able to see the body returned you have to print it on the console.

### Ubidots.getLastValue(dsLabel, varLabel)

This function is to get the float last value of a variable from the Ubidots API. Assign the device and variable labels from Ubidots:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "device_label_here";
local VAR_LABEL  =  "variable_label_here";

// e.i: 2.8
Ubidots.getLastValue(DEV_LABEL, VAR_LABEL); 
```

To be able to see the value returned you have to print it on the console.

### Ubidots.sendToVariable(varLabel, data)

This function is to send one value to a variable. The value is float type:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local VAR_LABEL  =  "test";

// sending 2.8 to Ubidots:  { "value": 2.8 }
Ubidots.sendToVariable(VAR_LABEL, 2.8);    
```


### Ubidots.sendToDevice(data)

This function is to send multiple variables to a device. Build a table to send mutiple variables to Ubidots:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

data <- {};
data.temp <- 25;
data.humid <- 40;
data.pressure <- 18.13;

 // { "body": "{\"pressure\": [{\"status_code\": 201}], \"humid\": [{\"status_code\": 201}], \"temp\": [{\"status_code\": 201}]}", "statuscode": 200, ... , "allow": "POST, OPTIONS", "vary": "Accept, Cookie" ...
Ubidots.sendToDevice(data);
```

