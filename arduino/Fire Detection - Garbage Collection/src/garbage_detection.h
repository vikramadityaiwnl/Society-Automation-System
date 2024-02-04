#ifndef garbage_detection_h
#define garbage_detection_h

#include <Arduino.h>
#include <Stepper.h>

class GarbageDetection {
  static const int MOISTURE_PIN = A5;

  static const int stepsPerRevolution = 360;
  Stepper myStepper = Stepper(stepsPerRevolution, 3, 4, 5, 6);

  public:
    void init() {
      pinMode(MOISTURE_PIN, INPUT);

      myStepper.setSpeed(50);
      myStepper.step(stepsPerRevolution);
      delay(500);
      myStepper.step(stepsPerRevolution * -1);

      Serial.println("Garbage detection initialized!");
    }
    
    void detect() {
      int moisture = analogRead(MOISTURE_PIN);
      Serial.println("Moisture: " + String(moisture));

      if(moisture >= 1022) {
        // idle
      } else if(moisture < 900) {
        // wet garbage
      } else {
        // dry garbage
      }

      delay(1000);
    }
};

#endif