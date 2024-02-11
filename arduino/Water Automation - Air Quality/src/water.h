#ifndef water_h
#define water_h

#include <Arduino.h>

class Water {
  static const int TRIGGER_PIN = 16;
  static const int ECHO_PIN = 3;
  static const int MOTOR_PIN = 4;

  static const long containerDepth = 11; // in cm

  public:
    void init() {
      pinMode(TRIGGER_PIN, OUTPUT);
      pinMode(ECHO_PIN, INPUT);
      pinMode(MOTOR_PIN, OUTPUT);
    }

    static void getWaterLevel(void (*sendResponse)(String)) {
      digitalWrite(TRIGGER_PIN, LOW);
      delayMicroseconds(2);
      digitalWrite(TRIGGER_PIN, HIGH);
      delayMicroseconds(10);
      digitalWrite(TRIGGER_PIN, LOW);
      
      long duration = pulseIn(ECHO_PIN, HIGH);
      long distance = duration * 0.034 / 2;
      int water = containerDepth - distance;
      int waterLevel = (water * 100) / containerDepth;

      if(waterLevel >= 80) {
        digitalWrite(MOTOR_PIN, LOW);
      } else if(waterLevel <= 0) {
        digitalWrite(MOTOR_PIN, HIGH);
        waterLevel = 0;
      } else {
        digitalWrite(MOTOR_PIN, HIGH);
      }

      Serial.println("Water Level: " + String(waterLevel) + " %");

      String jsonString = "{\"success\": \"true\", \"message\": \"water_level: " + String(waterLevel) + "\"}";
      sendResponse(jsonString);
    }
};

#endif