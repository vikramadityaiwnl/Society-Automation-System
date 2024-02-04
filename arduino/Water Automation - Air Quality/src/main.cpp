#include <Arduino.h>
#include <webserver.h>
#include <environment.h>
#include <water.h>

WebServer webServer;
Environment environment;
Water water;

void setup() {
  webServer.init();
  environment.init();
  water.init();
}

void loop() {
  webServer.handleClient();
}