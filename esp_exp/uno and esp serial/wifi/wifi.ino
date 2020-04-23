#include <SoftwareSerial.h>
#include <ESP8266WiFi.h>

const uint8_t D2   = 04;
const uint8_t D3   = 00;

SoftwareSerial NodeMCU(D2, D3);

void setup() {
  Serial.begin(9600);
  NodeMCU.begin(19200);
}

int i = 0;
void loop() {
  i++;
  NodeMCU.print(i);
  NodeMCU.println("\n");
  Serial.println(i);
  delay(300);
  if(i == 10){
    i = 0;
  }
}
