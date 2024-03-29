#ifndef webserver_h
#define webserver_h

#include <Arduino.h>
#include <ESP8266WebServer.h>
#include <environment.h>
#include <water.h>

ESP8266WebServer server(80);

class WebServer {
  const char* ssid = "be4st";
  const char* password = "thebe4st";

  public:
    void init() {
      Serial.begin(115200);

      WiFi.begin(ssid, password);
      Serial.println("Connecting");
      while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.print(".");
      }
      Serial.println("");
      Serial.print("Connected to ");
      Serial.println(ssid);
      Serial.print("IP address: ");
      Serial.println(WiFi.localIP());

      server.on("/aq", []() {
        Environment::handleAirQualityRequest(&sendResponse);
      });
      server.on("/water", []() {
        Water::getWaterLevel(&sendResponse);
      });

      server.begin();
      Serial.println("HTTP server started");
    }

    void handleClient() {
      server.handleClient();
    }

    static void sendResponse(String jsonString) {
      server.send(200, "application/json", jsonString);
    }
};

#endif