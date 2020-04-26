const int INPUT_TILT_SENSOR = 12;

const int STATUS_INTERVAL = 1000;
const int TILT_INTERVAL = 10;

const int CHECK_PRE = 5;

bool checkForStatus = true;
bool checkForTilt = true;

bool wasDisruptedInlastTwoSeconds = false;

long tiltStatus = -1;

void Tilt_setup() {
  pinMode(INPUT_TILT_SENSOR , INPUT);
}

void Tilt_loop() {
  unsigned long currentStatusWaitTime = millis() % STATUS_INTERVAL;
  
  //reporting the status
  if (currentStatusWaitTime >= (STATUS_INTERVAL - CHECK_PRE) && checkForStatus) {
    if(wasDisruptedInlastTwoSeconds)
    {
      //Serial.println("the car is on");
      Tilt_registerCarOn();
      wasDisruptedInlastTwoSeconds = false;
    }else{
      //Serial.println("the car is not on");
      Tilt_registerCarOff();
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
      //Serial.println("busted");
      wasDisruptedInlastTwoSeconds = true;
    }
    checkForTilt = false;
  } else if (currentTiltWaitTime <= CHECK_PRE && !checkForTilt) {
    checkForTilt = true;
  }
}

void Tilt_registerCarOn(){
  if(tiltStatus == -1){
    tiltStatus = (long) (millis() / 1000);
  }
}

void Tilt_registerCarOff(){
  tiltStatus = -1;
  //Serial.print("Tilt status: ");
  //Serial.println(tiltStatus);
}

bool Tilt_on(){
  return tiltStatus != -1;
}

long Tilt_secondsOn() {
  //this method should return -1 when tiltstatus is - 1
  if(tiltStatus < 0){
    return tiltStatus;
  }
  return (long) (millis() / 1000) - tiltStatus;
}
