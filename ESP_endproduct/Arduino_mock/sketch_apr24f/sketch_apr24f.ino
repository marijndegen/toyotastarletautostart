#include <SoftwareSerial.h>
SoftwareSerial ArduinoUno(2,3);

String readString;

void setup(){
  
  Serial.begin(9600);
  ArduinoUno.begin(19200);

}

void loop(){
  while (ArduinoUno.available()) {
   delay(2);  //delay to allow byte to arrive in input buffer
   char c = ArduinoUno.read();
   readString += c;
  }

  if (readString.length() >0) {
    if(readString == "start/"){
      Serial.println(readString);
    }
    if(readString == "stop/"){
      Serial.println(readString);
    }
    if(readString.startsWith("ignition/")){
     Serial.println(readString);
    }
    if(readString == "status/"){
      Serial.println(readString);
      
      //int aRandomNumber = random(0, 1000);
    
      char numberOfSecondsOn[13];
      sprintf(numberOfSecondsOn, "%d", /*aRandomNumber*/ 1 );
      
      ArduinoUno.write(numberOfSecondsOn);
    }
    readString="";
  }
}
