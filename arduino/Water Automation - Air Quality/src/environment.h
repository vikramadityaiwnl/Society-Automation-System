#ifndef environment_h
#define environment_h

#include <Arduino.h>

String env_category, env_color;
int env_value;

class Environment {
  static const int pinAQ = 4;

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
      env_value = analogRead(pinAQ);

      if(env_value > 0 && env_value < 50) {
        env_category = "Good";
        env_color = "#57a74f";
      } else if(env_value > 50 && env_value < 100) {
        env_category = "Statisfactory";
        env_color = "#a3c854";
      } else if(env_value > 100 && env_value < 200) {
        env_category = "Moderate";
        env_color = "#fff833";
      } else if(env_value > 200 && env_value < 300) {
        env_category = "Poor";
        env_color = "#f39c33";
      } else if(env_value > 300 && env_value < 400) {
        env_category = "Very Poor";
        env_color = "#e93f32";
      } else if(env_value > 500) {
        env_category = "Hazardous";
        env_color = "#af2d25";
      }
    }
};

#endif