#ifndef security_gate_h
#define security_gate_h

#include <Arduino.h>
#include <Servo.h>

Servo servo;

class SecurityGate {
  static const int GATE_PIN = 3;

  public:
    void init() {
      servo.attach(GATE_PIN);
    }

    static void openGate(void (*sendResponse)(String)) {
      sendResponse("{\"success\": \"true\", \"message\":\"Gate opened! Gate will be closed in 5 seconds!!\"}");
      
      servo.write(0);
      delay(160);
      servo.write(90);

      delay(5000);
      closeGate();
    }

    static void closeGate() {
      servo.write(180);
      delay(160);
      servo.write(90);
    }
};

#endif