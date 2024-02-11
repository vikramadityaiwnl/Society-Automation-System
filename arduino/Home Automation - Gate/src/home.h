#ifndef home_h
#define home_h

#include <Arduino.h>

class Home {
  static const int FAN_PIN = 4;
  static const int LED_ONE_PIN = 12;

  public:
    void init() {
      pinMode(LED_ONE_PIN, OUTPUT);
      pinMode(FAN_PIN, OUTPUT);
    }

    static String sendValues() {
      return "{\"led1\": \"" + String(digitalRead(LED_ONE_PIN)) + "\", \"fan\": \"" + String(digitalRead(FAN_PIN)) + "\"}";
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
        msg += "is off now!";
      } else if(path.indexOf("on") != -1) {
        val = HIGH;
        msg += "is on now!";
      } else {
        return sendResponse("{\"success\": \"false\"}");
      }

      digitalWrite(pin, val);

      String jsonString = "{\"success\": \"true\", \"message\": \"" + msg + "\"}";
      sendResponse(jsonString);
    }
};

#endif