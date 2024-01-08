int moisture;

void setup() {
  pinMode(3, OUTPUT);
  pinMode(6, INPUT);
}

void loop() {
  moisture = digitalRead(6);
  // if water level is full then cut the relay
  if(moisture == HIGH) {
    // low is to cut the relay
    digitalRead(3, LOW);
  } else {
    // high to continue providing signal water supply again
    digitalRead(3, HIGH);
  }

  delay(800);
}