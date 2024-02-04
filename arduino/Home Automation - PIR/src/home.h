#ifndef home_h
#define home_h

#include <Arduino.h>

// PIR Sensor Configuration
  const int PIR_PIN = 2;
  const int CALIBRATION_TIME = 30;
  long unsigned int lowIn;
  long unsigned int pause = 5000;

  boolean lockLow = true;
  boolean takeLowTime;
// End PIR Sensor Configuration

class Home {
  static const int LED_ONE_PIN = 12;
  static const int FAN_PIN = 4;

  public:
    void init() {
      pinMode(LED_ONE_PIN, OUTPUT);
      pinMode(FAN_PIN, OUTPUT);
    }

    static String sendValues() {
      return "{\"led1\": \"" + String(digitalRead(LED_ONE_PIN)) + "\"}";
    }

    static void handleRequest(String path, String component, void (*sendResponse)(String)) {
      int pin, val;
      String msg;

      if (component == "led1") {
        pin = LED_ONE_PIN;
        msg = "Led One ";
      } else if (component == "fan") {
        pin = FAN_PIN;
        msg = "Fan ";
      } else {
        return sendResponse("{\"success\": \"false\"}");
      }

      if(path.indexOf("off") != -1) {
        val = LOW;
        msg += "is off!";
      } else if(path.indexOf("on") != -1) {
        val = HIGH;
        msg += "is on";
      } else {
        return sendResponse("{\"success\": \"false\"}");
      }

      digitalWrite(pin, val);

      String jsonString = "{\"success\": \"true\", \"message\": \"" + msg + "\"}";
      sendResponse(jsonString);
    }

    static void initPIR() {
      pinMode(PIR_PIN, INPUT);
      digitalWrite(PIR_PIN, LOW);

      Serial.print("Calibrating PIR Sensor");
      for(int i = 0; i < CALIBRATION_TIME; i++){
        Serial.print(".");
        delay(1000);
      }
      Serial.println("PIR Sensor Ready!");
      delay(50);
    }

    static void handlePIR() {
      if(digitalRead(PIR_PIN) == HIGH) {
        digitalWrite(LED_ONE_PIN, HIGH);
        if(lockLow){
          // makes sure we wait for a transition to LOW before any further output is made:
          lockLow = false;            
          Serial.println("-----------------");
          Serial.print("Motion detected at ");
          Serial.print(millis()/1000);
          Serial.println(" sec"); 
          delay(50);
        }
        takeLowTime = true;
      }

      if(digitalRead(PIR_PIN) == LOW) {       
        digitalWrite(LED_ONE_PIN, LOW);

        if(takeLowTime) {
          lowIn = millis();
          takeLowTime = false;
        }

        // if the sensor is low for more than the given pause, we assume that no more motion is going to happen
        if(!lockLow && millis() - lowIn > pause){  
          // makes sure this block of code is only executed again after a new motion sequence has been detected
          lockLow = true;                        
          Serial.print("Motion ended at ");
          Serial.print((millis() - pause)/1000);
          Serial.println(" sec");
          delay(50);
        }
      }
    }
};

#endif