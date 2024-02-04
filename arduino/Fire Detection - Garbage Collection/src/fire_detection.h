#ifndef fire_detection_h
#define fire_detection_h

#include <Arduino.h>

class FireDetection {
  static const int FIRE_PIN = A0;
  static const int BUZZER_PIN = 12;

  public:
    void init() {
      pinMode(FIRE_PIN, INPUT);
      pinMode(BUZZER_PIN, OUTPUT);
      
      Serial.println("Fire detection initialized!");
    }

    void detect() {
      int fire = analogRead(FIRE_PIN);
      Serial.println("Fire: " + String(fire));

      if (fire <= 20) {
        // fire detected
        digitalWrite(BUZZER_PIN, HIGH);
      } else {
        // fire not detected
        digitalWrite(BUZZER_PIN, LOW);
      }

      delay(1000);
    }
};

#endif