#ifndef webserver_h
#define webserver_h
#define ON true
#define OFF false

#include <Arduino.h>
#include <ESP8266WebServer.h>
#include <home.h>
#include <security_gate.h>

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

      server.on("/status", []() {
        sendResponse("{\"success\": \"true\", \"message\":\"Welcome!\", \"home\": " + Home::sendValues() + "}");  
      });
      server.on("/gate", []() {
        SecurityGate::openGate(&sendResponse);
      });
      server.onNotFound([]() {
        String path = server.uri();
        if(path.indexOf("/home/led1") != -1) {
          Home::handleRequest(path, "led1", &sendResponse);
        } else if(path.indexOf("/home/fan") != -1) {
          Home::handleRequest(path, "fan", &sendResponse);
        } 
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