const byte Relais_contactPin = 9;
const byte Relais_ignitePin = 8;

//bool Relais_contact = false;
//bool Relais_ignite = false;
//
//int Relais_igniteTime = 0;

void Relais_setup() {
    pinMode(Relais_contactPin, OUTPUT); //contact
    pinMode(Relais_ignitePin, OUTPUT); //Start engine
}

void Relais_loop() {

}

void Relais_startContact(){
  digitalWrite(Relais_contactPin, HIGH);
}

void Relais_stopContact(){
  digitalWrite(Relais_contactPin, LOW);
}

void Relais_ignite(int ignitionTime){
  if(ignitionTime < 500 || ignitionTime > 2500){
    return;
  }
  
  unsigned long startTime = millis();

  digitalWrite(Relais_contactPin, HIGH);

  while(millis() - startTime <= ignitionTime){
    
  }

  digitalWrite(Relais_contactPin, LOW);
}
