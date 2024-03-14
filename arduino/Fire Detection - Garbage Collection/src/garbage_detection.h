#ifndef garbage_detection_h
#define garbage_detection_h

#define CLOCK_WISE 0
#define STOP 90
#define ANTI_CLOCK_WISE 180

#include <Arduino.h>
#include <Servo.h>

class GarbageDetection {
  static const int MOISTURE_PIN = 5;
  static const int SERVO_PIN = 6;
  static const int IR_SENSOR_PIN = 7;

  Servo servo;

  public:
    void init() {
      pinMode(MOISTURE_PIN, INPUT);
      pinMode(IR_SENSOR_PIN, INPUT);

      servo.attach(SERVO_PIN);
    }
    
    void detect() {
      if(digitalRead(IR_SENSOR_PIN) == LOW) {
        delay(500);
        int moisture = digitalRead(MOISTURE_PIN);

        if(moisture == HIGH) {
          moveServo(CLOCK_WISE);
        } else {
          moveServo(ANTI_CLOCK_WISE);
        }
      }
    }

    void moveServo(int direction) {
      if(direction == CLOCK_WISE) {
        servo.write(0);
        delay(100);
        servo.write(STOP);
        delay(1000);
        servo.write(180);
        delay(100);
        servo.write(STOP);
      } else {
        servo.write(180);
        delay(100);
        servo.write(STOP);
        delay(1000);
        servo.write(0);
        delay(100);
        servo.write(STOP);
      }
    }

    void stopServo() {
      servo.write(STOP);
    }
};

#endif