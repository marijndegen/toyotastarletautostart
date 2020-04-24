void setup() {
  DebugSerial_setup();
  SoftwareSerial_setup();
  WifiWeb_setup();
}

void loop() {
  DebugSerial_loop();
  SoftwareSerial_loop();
  WifiWeb_loop();
}
