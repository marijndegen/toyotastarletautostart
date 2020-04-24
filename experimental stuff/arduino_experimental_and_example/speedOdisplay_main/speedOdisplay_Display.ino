//In dit bestand worden de te ondernemen acties gedefineerd wanneer de statemachine zich in de state "Display" bevind.
void speedOdisplay_DISPLAY_entry(){
  
}

void speedOdisplay_DISPLAY_do(){
  gps_fetchNdisplay(1000, true);
}

void speedOdisplay_DISPLAY_exit(){
  
}
