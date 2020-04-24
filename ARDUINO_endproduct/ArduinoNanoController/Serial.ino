#include <SoftwareSerial.h>

const byte Serial_pin1 = 2;
const byte Serial_pin2 = 3;

SoftwareSerial ArduinoUno(Serial_pin1, Serial_pin2 );

String readString;

void Serial_setup() {
  ArduinoUno.begin(19200);
}

void Serial_loop() {
  while (ArduinoUno.available()) {
   delay(2);  //delay to allow byte to arrive in input buffer
   char c = ArduinoUno.read();
   readString += c;
  }
  

  if (readString.length() > 0) {
    if(readString == "start/" || readString == "stop/" || readString.startsWith("ignition/") || readString == "status/"){
      Serial.println(readString);
    }
    
    if(readString == "start/"){
      Relais_startContact();
    }
    
    if(readString == "stop/"){
      Relais_stopContact();
    }
    
    if(readString.startsWith("ignition/")){
      String ignitionTimeString = readString.substring(9);
      int ignitionTime = ignitionTimeString.toInt();
      Relais_ignite(ignitionTime);
    }
    
    if(readString == "status/"){
      //int aRandomNumber = random(0, 1000);
    
      char numberOfSecondsOn[13];
      int randomNumber = random( -2, 1);
      Serial.println(randomNumber);
      sprintf(numberOfSecondsOn, "%d", /*aRandomNumber*/ 1);
      
      ArduinoUno.write(numberOfSecondsOn);
    }
    readString="";
  }
  
}
