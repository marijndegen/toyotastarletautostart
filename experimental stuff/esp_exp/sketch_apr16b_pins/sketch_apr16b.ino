//arduino pin   actual
/*
  0               16
  1               05
  2               04
  3               00
  4               02
  5               14
  6               12
  7               13
  8               15
  9               03
  10              01
  */

int pin0 = 16;
int pin1 = 05;
int pin2 = 04;
int pin3 = 00;
int pin4 = 02;
int pin5 = 14;
int pin6 = 12;
int pin7 = 13;
int pin8 = 15;
int pin9 = 03;
int pin10 = 01;

void setup() {
  Serial.begin(115200);

  pinMode(pin1, OUTPUT);
  pinMode(pin2, OUTPUT);
  
  digitalWrite(pin1, LOW);
  digitalWrite(pin2, LOW);
  
  delay(1000);
  
}

int counter = 0;

void loop(){
    if(counter < 5){
      digitalWrite(pin1, LOW);
    }else{
      digitalWrite(pin1, HIGH);
    }

    if(counter < 10){
      digitalWrite(pin2, LOW);
    }else{
      digitalWrite(pin2, HIGH);
    }
    
    Serial.print("Pin output ");
    Serial.println(counter);
    delay(1000);
    counter++;
}
