void setup() {
  Debug_setup();
  Relais_setup();
  Serial_setup();
  Tilt_setup();
}

void loop() {
  Debug_loop();
  Relais_loop();
  Serial_loop();
  Tilt_loop();
}
