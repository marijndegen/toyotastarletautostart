//In dit bestand worden de te ondernemen acties gedefineerd wanneer de statemachine zich in de state "NoConnection" bevind.
void speedOdisplay_NOCONNECTION_entry(){
  
}

void speedOdisplay_NOCONNECTION_do(){
  gps_fetchNdisplay(1000, false);
}

void speedOdisplay_NOCONNECTION_exit(){
  
}
