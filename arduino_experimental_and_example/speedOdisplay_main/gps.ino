/*
 * Alle code die de gps nodig heeft.
 */

#include <TinyGPS++.h>
#include <SoftwareSerial.h>

static const int RXPin = A0, TXPin = A2;
static const uint32_t GPSBaud = 9600;

// The TinyGPS++ object
TinyGPSPlus gps;

// The serial connection to the GPS device
SoftwareSerial ss(RXPin, TXPin);

/*
 * Deze functie moet constant worden uitgevoerd om correct gps signaal te verkrijgen.
 * MS: het aantal milliseconden die ter beschikking wordt gesteld om te fetchen
 * DISLPLAY: geeft aan of er tijdens het fetchen de snelheid moet worden weergegeven.
 */
void gps_setup(){
  ss.begin(GPSBaud);
}

boolean gps_hasSignal(){
  if(gps.satellites.value() >= 3 && gps.satellites.isValid()){
    return true;
  }else{
    return false;
  }
}

void gps_fetchNdisplay(unsigned long ms, boolean show)
{
  unsigned long start = millis();
  do 
  {
    while (ss.available())
      gps.encode(ss.read());
      if(show){
        display(speed);
      }else{
        laadAnimatie();
      }
  } while (millis() - start < ms);
  speed = (int)gps.speed.kmph();
}
