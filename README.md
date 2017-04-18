# Ubidots 1.0.0

This library allows you to easily integrate the Ubidots Platform into your agent code. It provides an easy way to to send multiple values to the Ubidots API &mdash; you just need the name and the value that you want to send. In addition, you are able to get the last value from a variable of your Ubidots account.

**To add this library to your project, add** ```#require "Ubidots.agent.lib.nut:1.0.0"``` **to the top of your agent code.**

## Class Usage 

### Constructor: Ubidots.Client(*token[, server]*)

To create a new Ubidots client, call the constructor and pass in your Ubidots Token. Optionally, you can pass an alternative server address as a second parameter.

```squirrel
Ubidots <- Ubidots.Client("<YOUR_TOKEN>");
```

## Class Methods 

## Ubidots.setDeviceName(*deviceName*)

This method allows you to set the name of your data source. Typically, this will be the ID of your device, but you can pass in any string.
 
```squirrel
Ubidots.setDeviceName(imp.configparams.deviceid);
```

### Ubidots.get(*deviceLabel, variableLabel, callback*)

This method is used to get a variable’s value from the Ubidots API. To be able to do this, you first need to have assigned the device and variable labels. 

The callback function will be called when the value has been retrieved. It takes a single parameter: a table containing the data from the Ubidots server. 

```squirrel
local DEV_LABEL = "<your_device_label>";
local VAR_LABEL = "<your_var_label>";

Ubidots.get(DEV_LABEL, VAR_LABEL, function(data) {
    foreach (key, value in data) {
        server.log(key + ": " + typeof value);
    }
});

// eg. displays:
// count: integer
// results: array
```

### Ubidots.getLastValue(*deviceLabel, variableLabel, callback*)

This method retrieves the most recent value of a variable from the Ubidots API. To be able to do this, you first need to have assigned the device and variable labels. 

The callback function will be called when the value has been retrieved. It takes a single parameter: the value returned by the Ubidots server. 


```squirrel
Ubidots.getLastValue(DEV_LABEL, VAR_LABEL, function(value) {
    server.log(value);
});

// eg. sisplays: '2.8'
```

### Ubidots.sendToVariable(*variableLabel, data[, callback]*)

This method sends data to a variable, specified by its label. The value can be any an integer, a float, a string or a table.

The method can take an optional callback which itself takes a single parameter into which the server's response is placed. The response is a table with the following keys:

| Key | Type | Description |
| --- | --- | --- |
| *statuscode* | Integer | HTTP status code (or *libcurl* error code) |
| *headers*    | Table   | Squirrel table of returned HTTP headers |
| *body*       | String  | Returned HTTP body (if any) |

```squirrel
local varLab = "test";

// Send 2.8 to Ubidots: { "value": 2.8 }
Ubidots.sendToVariable(varLab, 2.8); 
```

### Ubidots.sendToDevice(*data[, callback]*)

This method is used to send multiple variables to a device. The values are placed within a table which is passed into the method’s *data* parameter.

The method can take an optional callback which itself takes a single parameter into which the server's response is placed. The response is a table with the following keys:

| Key | Type | Description |
| --- | --- | --- |
| *statuscode* | Integer | HTTP status code (or *libcurl* error code) |
| *headers*    | Table   | Squirrel table of returned HTTP headers |
| *body*       | String  | Returned HTTP body (if any) |

```squirrel
data <- {};
data.temp <- 25;
data.humid <- 40;
data.pressure <- 18.13;

Ubidots.sendToDevice(data);
```

## License

The library is licensed under the [MIT License](LICENSE).
