#ifndef pir_h
#define pir_h

#include <Arduino.h>

class PIR {
  static const int PIR_PIN = 3;
  static const int LED_PIN = 13;
  static const int CALIBRATION_TIME = 30;        

  long unsigned int lowIn;         
  long unsigned int pause = 5000;  

  boolean lockLow = true;
  boolean takeLowTime;  

  public:
    void init() {
      pinMode(PIR_PIN, INPUT);
      pinMode(LED_PIN, OUTPUT);

      digitalWrite(PIR_PIN, LOW);
      Serial.print("Calibrating sensor ");
        for(int i = 0; i < CALIBRATION_TIME; i++) {
          Serial.print(".");
          delay(1000);
        }
        Serial.println(" done!!");
        delay(50);
      }

    void handlePIR() {
      if(digitalRead(PIR_PIN) == HIGH) {
        digitalWrite(LED_PIN, HIGH);
        if(lockLow){  
          lockLow = false;            
          delay(50);
        }
        takeLowTime = true;
      }

      if(digitalRead(PIR_PIN) == LOW){       
        digitalWrite(LED_PIN, LOW);

        if(takeLowTime) {
          lowIn = millis();
          takeLowTime = false;
        }

        if(!lockLow && millis() - lowIn > pause) {  
          lockLow = true;                        
          delay(50);
        }
      }
    }
};

#endif