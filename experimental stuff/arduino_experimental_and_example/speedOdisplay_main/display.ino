/*
 * Alle code die het display nodig heeft.
 */

//Onderstaande variabelen worden gebruikt voor het weergeven van een getal.
const int segLength = 8;

const int pinA      = 2;
const int pinB      = 3;
const int pinC      = 4;
const int pinD      = 5;
const int pinE      = 6;
const int pinF      = 7;
const int pinG      = 8;
const int pinH      = 12;
const int SEGMENT [segLength] = {pinA, pinB, pinC, pinD, pinE, pinF, pinG, pinH};

//Onderstaande variabelen worden gebruikt om te bepalen welk getal gecontrolleerd wordt.
const int digitLength = 3;

int D1 = 9;
int D2 = 10;
int D3 = 11;
const int DIGIT [digitLength] = {D1, D2, D3};

//Onderstaande variableen definieeren de figuren die mogelijk zijn.
const byte LENGTE = 12;
const byte PATROON [LENGTE] = {
  B00111111,//0
  B00000110,//1
  B01011011,//2
  B01001111,//3
  B01100110,//4
  B01101101,//5
  B01111101,//6 
  B00000111,//7
  B01111111,//8
  B01101111,//9
  B01100011,//10-> °
  B01011100,//11-> ȫ
};

void display_setup(){
  pinMode(pinA, OUTPUT);
  pinMode(pinB, OUTPUT);
  pinMode(pinC, OUTPUT);
  pinMode(pinD, OUTPUT);
  pinMode(pinE, OUTPUT);
  pinMode(pinF, OUTPUT);
  pinMode(pinG, OUTPUT);
  pinMode(pinH, OUTPUT);
  pinMode(D1, OUTPUT);
  pinMode(D2, OUTPUT);
  pinMode(D3, OUTPUT);
}

void display(int n){
  int x = (n / 100U) % 10;
  int y = (n / 10U)  % 10;
  int z = (n / 1U)   % 10;
  const int VALUE [digitLength] = {x, y, z};
  
  digitalWrite(D1, HIGH);
  digitalWrite(D2, HIGH);
  digitalWrite(D3, HIGH);
  for(int i = 0; i < digitLength; i++){
  
    if(i == 0){
      digitalWrite(D1, LOW);
      digitalWrite(D2, HIGH);
      digitalWrite(D3, HIGH);
    }else if(i == 1){
      digitalWrite(D1, HIGH);
      digitalWrite(D2, LOW);
      digitalWrite(D3, HIGH);
    }else if(i == 2){
      digitalWrite(D1, HIGH);
      digitalWrite(D2, HIGH);
      digitalWrite(D3, LOW);
    }
    
    numberDisplay(VALUE[i]);
  }
}

void laadAnimatie(){
  boolean spring;
  if(millis() % 1000 < 500){
    spring = true;
  }else{
    spring = false;
  }

  for(int i = 0; i < digitLength; i++){
    
        if(i == 0){
          digitalWrite(D1, LOW);
          digitalWrite(D2, HIGH);
          digitalWrite(D3, HIGH);
        }else if(i == 1){
          digitalWrite(D1, HIGH);
          digitalWrite(D2, LOW);
          digitalWrite(D3, HIGH);
        }else if(i == 2){
          digitalWrite(D1, HIGH);
          digitalWrite(D2, HIGH);
          digitalWrite(D3, LOW);
        }

        spring = !spring;

        if(spring){
          numberDisplay(10);
        }else{
          numberDisplay(11);
        }
  }
  
}

void numberDisplay(int value){
    byte paternofcurrentvalue = PATROON[value];
  
    for(int i = 0; i < 8; i++){       
        int waarde = bitRead(PATROON[value], i);
        digitalWrite(SEGMENT[i], waarde);
    }
    for(int i = 0; i < 8; i++){       
        digitalWrite(SEGMENT[i], LOW);
    }

}

