
const int OUTPUT_TILT_SENSOR = 12;
const int INPUT_TILT_SENSOR = 13;

const int STATUS_INTERVAL = 1000;
const int TILT_INTERVAL = 10;

const int CHECK_PRE = 5;

bool checkForStatus = true;
bool checkForTilt = true;

int motor = 0;

bool wasDisruptedInlastTwoSeconds = false;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  pinMode(OUTPUT_TILT_SENSOR, OUTPUT);
  pinMode(INPUT_TILT_SENSOR , INPUT);
  digitalWrite(OUTPUT_TILT_SENSOR, HIGH);
}

void loop() {

  unsigned long currentStatusWaitTime = millis() % STATUS_INTERVAL;
  
  //reporting the status
  if (currentStatusWaitTime >= (STATUS_INTERVAL - CHECK_PRE) && checkForStatus) {
    if(wasDisruptedInlastTwoSeconds)
    {
      Serial.println("the car is on");
      wasDisruptedInlastTwoSeconds = false;
    }else{
      Serial.println("the car is not on");
    }
    checkForStatus = false;
  } else if (currentStatusWaitTime <= CHECK_PRE && !checkForStatus) {
    checkForStatus = true;
  }


  unsigned long currentTiltWaitTime = millis() % TILT_INTERVAL;

  //reporting the tilt
  if (currentTiltWaitTime >= (TILT_INTERVAL - CHECK_PRE) && checkForTilt && !wasDisruptedInlastTwoSeconds) {
    if(digitalRead(INPUT_TILT_SENSOR) == LOW)
    {
      Serial.println("busted");
      wasDisruptedInlastTwoSeconds = true;
    }
    checkForTilt = false;
  } else if (currentTiltWaitTime <= CHECK_PRE && !checkForTilt) {
    checkForTilt = true;
  }
 
}
