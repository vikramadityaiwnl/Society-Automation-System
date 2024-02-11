#ifndef fire_detection_h
#define fire_detection_h

#include <Arduino.h>

class FireDetection {
  static const int FIRE_PIN = 3;
  static const int BUZZER_PIN = 13;

  public:
    void init() {
      pinMode(FIRE_PIN, INPUT);
      pinMode(BUZZER_PIN, OUTPUT);
    }

    void detect() {
      int fire = digitalRead(FIRE_PIN);

      if(fire == HIGH) {
        digitalWrite(BUZZER_PIN, HIGH);
      } else {
        digitalWrite(BUZZER_PIN, LOW);
      }

      delay(1000);
    }
};

#endif