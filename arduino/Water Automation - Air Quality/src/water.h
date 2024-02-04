#ifndef water_h
#define water_h

#include <Arduino.h>

class Water {
  static const int triggerPin = 16;
  static const int echoPin = 12; 
  static const long containerDepth = 12; // in cm

  public:
    void init() {
      pinMode(triggerPin, OUTPUT);
      pinMode(echoPin, INPUT);
    }

    static void getDistance(void (*sendResponse)(String)) {
      digitalWrite(triggerPin, LOW);
      delayMicroseconds(2);
      digitalWrite(triggerPin, HIGH);
      delayMicroseconds(10);
      digitalWrite(triggerPin, LOW);
      
      long duration = pulseIn(echoPin, HIGH);
      long distance = duration * 0.034 / 2;
      int water = containerDepth - distance;
      int waterLevel = (water * 100) / containerDepth;

      Serial.println("Water Level: " + String(waterLevel) + " %");

      String jsonString = "{\"success\": \"true\", \"message\": \"water_level: " + String(waterLevel) + "\"}";
      sendResponse(jsonString);
    }
};

#endif