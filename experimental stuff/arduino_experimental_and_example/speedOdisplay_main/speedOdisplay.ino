/*
 * In dit bestand wordt de huidige state bepaald, en alle andere state's gedefinieerd.
 */

 //De state waar de machien zich op ieder moment in bevindt
int huidigeStaat;

//Dit zijn alle states waarin de machine zich kan bevinden.
const int speedOdisplay_NOCONNECTION  = 0;
const int speedOdisplay_DISPLAY       = 1;

void speedOdisplay_Setup(){
  display_setup();
  gps_setup();
  speedOdisplay_DISPLAY_entry();
  Serial.begin(9600);
  speed = 0;
}

void speedOdisplay_Loop(){

  if(gps_hasSignal()){
    
  }else{
    
  }
  
  //Switch architectuur.
  switch (huidigeStaat){
    case speedOdisplay_NOCONNECTION:
      speedOdisplay_NOCONNECTION_do();
      if (gps_hasSignal()) {
        huidigeStaat = speedOdisplay_DISPLAY;
        speedOdisplay_NOCONNECTION_exit();
        speedOdisplay_DISPLAY_entry();
      }
    break;
    case speedOdisplay_DISPLAY:
      speedOdisplay_DISPLAY_do();
      if (!gps_hasSignal()) {
        huidigeStaat = speedOdisplay_NOCONNECTION;
        speedOdisplay_DISPLAY_exit();
        speedOdisplay_NOCONNECTION_entry();
      }
    break;
  }

  
}

