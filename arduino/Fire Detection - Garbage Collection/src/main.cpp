#include <Arduino.h>
#include <fire_detection.h>
#include <garbage_detection.h>

FireDetection fireDetection;
GarbageDetection garbageDetection;

void setup() {
  Serial.begin(9600);

  fireDetection.init();
  garbageDetection.init();
}

void loop() {
  // fireDetection.detect();
  // garbageDetection.detect();
}