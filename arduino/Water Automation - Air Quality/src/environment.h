#ifndef environment_h
#define environment_h

#include <Arduino.h>

String env_category, env_color;
int env_value;

class Environment {
  static const int pinAQ = 12;

  public:
    void init() {
      pinMode(pinAQ, INPUT);
    }

    static String getValues() {
      readAQ();

      return "{\"category\":\"" + env_category + "\",\"color\":\"" + env_color + "\",\"value\":\"" + String(env_value) + "\"}";
    }

    static void handleAirQualityRequest(void (*sendResponse)(String)) {
      readAQ();

      String jsonString = "{\"success\": \"true\", \"category\":\"" + env_category + "\", \"color\":\"" + env_color + "\", \"value\":\"" + String(env_value) + "\", \"message\":\"Air Quality is " + env_category + "\"}";
      sendResponse(jsonString);
    }

    static void readAQ() {
      env_value = digitalRead(pinAQ);

      if(env_value == HIGH) {
        env_category = "Good";
        env_color = "#57a74f";
      } else if(env_value == LOW) {
        env_category = "Bad";
        env_color = "#e93f32";
      }
    }
};

#endif