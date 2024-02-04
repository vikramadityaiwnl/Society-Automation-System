#include <Arduino.h>
#include <webserver.h>
#include <home.h>

WebServer webServer;
Home home;

void setup() {
  webServer.init();

  home.init();
  home.initPIR();
}

void loop() {
  webServer.handleClient();
  home.handlePIR();
}