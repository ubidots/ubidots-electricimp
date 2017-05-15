// MIT License
//
// Copyright 2017 Ubidots
// Copyright 2017 Electric
//
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

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