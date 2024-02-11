#include <Arduino.h>
#include <webserver.h>
#include <home.h>
#include <security_gate.h>

WebServer webServer;
Home home;
SecurityGate securityGate;

void setup() {
  webServer.init();

  home.init();
  securityGate.init();
}

void loop() {
  webServer.handleClient();
}