#include <SoftwareSerial.h>
SoftwareSerial ArduinoUno(2,3);

void setup(){
	
	Serial.begin(9600);
	ArduinoUno.begin(19200);

}

void loop(){
	
	while(ArduinoUno.available()>0){
  	float val = ArduinoUno.parseFloat();
  	if(ArduinoUno.read()== '\n'){
  	  Serial.println(val);
    }
  }
  delay(30);
}
