#include <SoftwareSerial.h>
#include <ESP8266WiFi.h>

//This is actually D2 and D3 on the ESP board, cabels should be wired according to the diagram
const uint8_t D2   = 04;
const uint8_t D3   = 00;

SoftwareSerial softwareSerial(D2, D3);

const byte SoftwareSerial_maxCommandLength = 13;

char SoftwareSerial_command[SoftwareSerial_maxCommandLength];
char SoftwareSerial_output[SoftwareSerial_maxCommandLength];

char SoftwareSerial_startContact[] = "start/"; 
char SoftwareSerial_stopContact[] = "stop/"; 

char SoftwareSerial_startIgnition[] = "ignition/"; 
char SoftwareSerial_status[] = "status/"; 

bool SoftwareSerial_commandRed = true;
bool SoftwareSerial_outputRed = true;

void SoftwareSerial_setup() {
  softwareSerial.begin(19200);
}

void SoftwareSerial_loop() {
  //Write the command to the arduino serial line and reset the state
  if(!SoftwareSerial_commandRed){
    Serial.print("Now doing: ");
    Serial.println(SoftwareSerial_command);
    int bytesSent = softwareSerial.write(SoftwareSerial_command);
    SoftwareSerial_commandRed = true;
    SoftwareSerial_command[0] = 0;
  }
}

void SoftwareSerial_executeCommand(char commandToExecute[]){
  strcpy(SoftwareSerial_command, commandToExecute); 
  SoftwareSerial_commandRed = false;
}

String SoftwareSerial_readOutput(){
  String output_copy = SoftwareSerial_output;
  SoftwareSerial_output[0] = 0;
  SoftwareSerial_outputRed = true;
  return output_copy;
}

void SoftwareSerial_new_command(String command){
  
}

void SoftwareSerial_reset_state(){
  SoftwareSerial_command[0] = 0;
  SoftwareSerial_output[0] = 0;

  SoftwareSerial_commandRed = true;
  SoftwareSerial_outputRed = true;
}

/*
 * Public methods
 */

/*
 * Setters
 */
void SoftwareSerial_command_startContact() {
  SoftwareSerial_executeCommand(SoftwareSerial_startContact);
}

void SoftwareSerial_command_stopContact() {
  SoftwareSerial_executeCommand(SoftwareSerial_stopContact);
}

void SoftwareSerial_command_startIgnition(int ignitionTime) {
  char commandToExecute[13];
  sprintf(commandToExecute, "%s%d", SoftwareSerial_startIgnition, ignitionTime);
  SoftwareSerial_executeCommand(commandToExecute);
}

void SoftwareSerial_command_status() {
  SoftwareSerial_executeCommand(SoftwareSerial_status);
}

/*
 * Getters
 */
int SoftwareSerial_fetch_status() {

}
