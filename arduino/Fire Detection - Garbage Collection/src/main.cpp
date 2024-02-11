#include <Arduino.h>
#include <fire_detection.h>
#include <garbage_detection.h>
#include <security_gate.h>

FireDetection fireDetection;
GarbageDetection garbageDetection;
SecurityGate securityGate;

void setup() {
  Serial.begin(9600);

  fireDetection.init();
  garbageDetection.init();
  securityGate.init();
}

void loop() {
  // fireDetection.detect();
  // garbageDetection.detect();
}