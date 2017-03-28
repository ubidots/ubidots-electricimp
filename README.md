# Ubidots v1.0.0

The Ubidots library allows you to easily integrate your agent code with the Ubidots Platform. This library provides an easy way to to send multiple values to the Ubidots API, you just need the name and the value that you want to send. In addition you are able to get the last value from a variable of your Ubidots account.

To add this library to your project, add ```#require "Ubidots.class.nut:1.0.0"```  to the top of your agent code.

##  Class Usage 

### Constuctor: Ubidots.Client(token, server)

To create a new Ubidots client assign your Ubidots' **Token** to the constructor:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN")
```

##  Class Methods 


### Ubidots.get(dsLabel, varLabel)

This function is to get body of a variable from the Ubidots API:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";

// e.i: {"count": 774, ... , "results": [{"value": 2.8, "timestamp":1490736636651, "context": {}}, ... ]}
Ubidots.get(DEV_LABEL, VAR_LABEL);
```

To be able to see the body returned you have to print it on the console.

### Ubidots.getLastValue(dsLabel, varLabel)

This function is to get the float last value of a variable from the Ubidots API:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";

// e.i: 2.8
Ubidots.getLastValue(DEV_LABEL, VAR_LABEL); 
```

To be able to see the value returned you have to print it on the console.

### Ubidots.sendToVariable(dsLabel, varLabel, data)

This function is to send one value to a variable. The value is float type:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";

// sending 2.8 to Ubidots:  { "value": 2.8 }
Ubidots.sendToVariable(DEV_LABEL, VAR_LABEL, 2.8);    

```


### Ubidots.sendToDevice(dsLabel, data)

This function is to send multiple variables to a device. Build a table to send mutiple variables to Ubidots:

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";

data <- {};
data.temp <- 24.3;
data.humid <- 30;
data.pressure <- 3;

// Sending the data table: { "pressure": 3, "humid": 30, "temp": 24.3 }
Ubidots.sendToDevice(DEV_LABEL, data);
```

