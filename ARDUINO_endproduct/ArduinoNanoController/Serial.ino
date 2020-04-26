#include <SoftwareSerial.h>

const byte Serial_pin1 = 2;
const byte Serial_pin2 = 3;

SoftwareSerial ArduinoUno(Serial_pin1, Serial_pin2 );

String readString;

bool contact = false;

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
      Serial.print(readString + " ");
    }
    
    if(readString == "start/"){
      Relais_startContact();
      contact = true;
    }
    
    if(readString == "stop/"){
      Relais_stopContact();
      contact = false;
    }
    
    if(readString.startsWith("ignition/")){
      Serial.println("1234");
      if(contact){
        String ignitionTimeString = readString.substring(9);
        int ignitionTime = ignitionTimeString.toInt();
        Relais_ignite(ignitionTime);  
      }
    }
    
    if(readString == "status/"){
      //int aRandomNumber = random(0, 1000);
    
//      char numberOfSecondsOn[13];
//      int randomNumber = random( -2, 1);
//      Serial.println(randomNumber);
//      sprintf(numberOfSecondsOn, "%d", /*aRandomNumber*/ -2);


      long statusCar;
      if(!contact){
        statusCar = -2;
      } else if (contact && !Tilt_on()){
        statusCar = -1;
      } else if (contact && Tilt_on()){
        statusCar = Tilt_secondsOn();
      }

      //todo it doesn't really turn off based on the tilt, 
      //once it was turned on the first time it shows the initial time afterwards

      Serial.println(statusCar);

      char serialCarStatus[13];
      sprintf(serialCarStatus, "%d", statusCar);
      ArduinoUno.write(serialCarStatus);
    }
    readString="";

    Serial.print("Tilt_secondsOn: ");
    Serial.println(Tilt_secondsOn());
  }
  
}
