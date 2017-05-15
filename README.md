# Ubidots 1.0.0

This library allows you to easily connect your agent code to the [Ubidots Platform](https://ubidots.com/). It provides an easy way to to send multiple values to the Ubidots API &mdash; you just need the name and the value that you want to send. In addition, you are able to get the last value from a variable of your Ubidots account.

**To add this library to your project, add** ```#require "Ubidots.agent.lib.nut:1.0.0"``` **to the top of your agent code.**

## Class Usage 

### Constructor: Ubidots.Client(*token[, server]*)

To create a new Ubidots client object, call the constructor and pass in your Ubidots authorization token. Optionally, you can also pass an alternative server address as a second parameter.

```squirrel
Ubidots <- Ubidots.Client("<YOUR_AUTH_TOKEN>");
```

## Class Methods 

## Ubidots.setDeviceLabel(*deviceLabel*)

This method allows you to set the label of your data source (ie. a device). When you instantiate the Ubidots client object, the device label is automatically set to the ID of your device. Should you prefer a more friendly label for your device, you can use this method to set the device label to any other string. This value is used for all subsequent attempts to send data to Ubidots.

```c
Ubidots.setDeviceLabel("device_label_here")
```

### Ubidots.get(*deviceLabel, variableLabel, callback*)

This method is used to get a variable’s value from the Ubidots API. The variable is identified by its label and the label of its parent device. The method’s third parameter is a callback function which will be called when the value has been retrieved. The callback takes a single parameter: a table containing the data from the Ubidots server. 

```squirrel
local devLabel = "<your_device_label>";
local varLabel = "<your_variable_label>";

Ubidots.get(devLabel, varLabel, function(data) {
    foreach (key, value in data) {
        server.log(key + ": " + typeof value);
    }
});

// eg. displays:
// count: integer
// results: array
```

### Ubidots.getLastValue(*deviceLabel, variableLabel, callback*)

This method retrieves the most recent value of a variable from the Ubidots API. The variable is identified by its label and the label of its parent device. The method’s third parameter is a callback function which will be called when the value has been retrieved. The callback takes a single parameter: the value returned by the Ubidots server. 


```squirrel
local devLabel = "<your_device_label>";
local varLabel = "<your_variable_label>";

Ubidots.getLastValue(devLabel, varLabel, function(value) {
    server.log(value);
});

// eg. displays: '2.8'
```

### Ubidots.sendToVariable(*variableLabel, data[, callback]*)

This method sends data to a variable, as specified by its label. The value can be an integer, a float, a string or a table. An existing variable is updated by the call; if the variable is new, it is created automatically.

The method can take an *optional* callback which itself takes a single parameter into which the server's full response is placed. The response is a table with the following keys:

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

This method is used to send multiple variables to Ubidots using the data source (device) label held by the Ubidots client object (as set using *setDeviceName()*). The variables and their values are placed within a table as key-value pairs, and this table is then passed into the method’s *data* parameter. Existing variables are updated by the call; new variables are created automatically.

The method can take an *optional* callback which itself takes a single parameter into which the server's full response is placed. The response is a table with the following keys:

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
