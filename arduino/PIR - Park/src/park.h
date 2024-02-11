#ifndef park_h
#define park_h

#include <Arduino.h>

class Park {
  static const int MOISTURE_PIN = 5;
  static const int MOTOR_PIN = 6;

  public:
    void init() {
      pinMode(MOISTURE_PIN, INPUT);
      pinMode(MOTOR_PIN, OUTPUT);
    }

    void handleMoisture() {
      int moisture = digitalRead(MOISTURE_PIN);
      if(moisture == HIGH) {
        digitalWrite(MOTOR_PIN, HIGH);
      } else {
        digitalWrite(MOTOR_PIN, LOW);
      }
    }
};

#endif