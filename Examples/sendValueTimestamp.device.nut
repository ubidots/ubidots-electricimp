sensor <- hardware.pin9;
sensor.configure(ANALOG_IN);

function mainLoop() {
    imp.wakeup(1.0, mainLoop);
    local value = hardware.pin9.read();
    agent.send("saveValue", value);
} 

mainLoop();