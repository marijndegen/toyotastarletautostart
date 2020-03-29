/*
 * Arduino Nano test relays
 */

void setup() {
  // put your setup code here, to run once:
    pinMode(2, OUTPUT); //Start engine
    pinMode(3, OUTPUT); // Other stuff 

    
    Serial.begin(9600);
    Serial.println("start");
    
    //start the car
    digitalWrite(3, HIGH);
    delay(2500);
    digitalWrite(2, HIGH);
    delay(1000); //1750 winter, ca. 1350 normaal //1000 minimal
    digitalWrite(2, LOW);
    Serial.println("stop");
    
    //shut down the car
    //digitalWrite(3, LOW);
}

void loop() {
  // put your main code here, to run repeatedly:

}
