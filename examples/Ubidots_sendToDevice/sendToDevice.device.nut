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