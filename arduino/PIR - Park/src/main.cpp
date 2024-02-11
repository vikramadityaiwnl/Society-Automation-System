#include <Arduino.h>
#include <pir.h>
#include <park.h>

PIR pir;
Park park;

void setup() {
  Serial.begin(9600);

  pir.init();
  park.init();
}

void loop() {
  pir.handlePIR();
  park.handleMoisture();
}