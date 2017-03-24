# Ubidots v1.0.0

The Ubidots library allows you to easily integrate your agent code with the Ubidots Platform. This library provides an easy way to to send multiple values to the Ubidots API, you just need the name and the value that you want to send. In addition you are able to get the last value from a variable of your Ubidots account.

To add this library to your project, add ```#require "Ubidots.class.nut:1.0.0"```  to the top of your agent code.

##  Class Usage 

### Constuctor: Ubidots.Client(token, server)

To create a new Ubidots client, you need to call the constructor with your Ubidots' **Token**:
```c
Ubidots <- Ubidots.Client("YOUR_TOKEN")
```
##  Class Methods 


### Ubidots.get(dsLabel, varLabel)

This function is to get body of a variable from the Ubidots API:

**Agent Code**

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";

device.on("get", function(data){
    device.send("get", Ubidots.get(DEV_LABEL, data));   
});
```

**Device Code**

```c 
function mainLoop() {
    agent.send("get", "test");
    imp.wakeup(10.0, mainLoop);
} 

mainLoop();

agent.on("get", function(data) {
    server.log(data);
});
```
### Ubidots.getLastValue(dsLabel, varLabel)

This function is to get the last value of a variable from the Ubidots API:

**Agent Code**

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";

device.on("get", function(data){
    device.send("get", Ubidots.getLastValue(DEV_LABEL, data));   
});
```

**Device Code**

``` c
function mainLoop() {
    agent.send("get", "hola1");
    imp.wakeup(10.0, mainLoop);
} 

mainLoop();

agent.on("get", function(data) {
    server.log(data);
});
```

### Ubidots.sendToVariable(dsLabel, varLabel, data)

This function is to send one value to a variable:

**Agent Code**

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";
local VAR_LABEL  =  "test";

device.on("saveValue", function(value) {
    Ubidots.sendToVariable(DEV_LABEL, VAR_LABEL, value);    
    server.log("Sending data to Ubidots");
    server.log(value);
}); 

```

**Device Code**

``` c
sensor <- hardware.pin9;
sensor.configure(ANALOG_IN);

function mainLoop() {
    imp.wakeup(1.0, mainLoop);
    local value = hardware.pin9.read();
    agent.send("saveValue", value);
} 

mainLoop();
```

### Ubidots.sendToDevice(dsLabel, data)

This function is to send multiple variables to a device:

**Agent Code**

```c
Ubidots <- Ubidots.Client("YOUR_TOKEN");

local DEV_LABEL = "ElectricImp";

device.on("saveValue", function(data){
    
    Ubidots.sendToDevice(DEV_LABEL, data);
    server.log("Sending data to Ubidots");
    server.log(http.jsonencode(data));
});
```

**Device Code**

```c
data <- {};
data.temp <- 0;
data.humid <- 0;
data.pressure <- 0;

TempSensor <- hardware.pin9;
TempSensor.configure(ANALOG_IN);

HumSensor <- hardware.pin8;
HumSensor.configure(ANALOG_IN);

PressureSensor <- hardware.pin5;
PressureSensor.configure(ANALOG_IN);

function mainLoop() {
    data.temp = TempSensor.read();
    data.humid = HumSensor.read();
    data.pressure = PressureSensor.read();
    
    agent.send("saveValue", data);
        
    imp.wakeup(10.0, mainLoop);

} 

mainLoop(); 
```
