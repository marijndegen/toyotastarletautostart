#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

#ifndef APSSID
#define APSSID "ToyotaStarlet"
#define APPSK  "u09f8202fi2h390uh209f3u8h"
#endif

/* These are the credentials of the AP */
const char *ssid = APSSID;
const char *password = APPSK;

ESP8266WebServer server(46969);

void WifiWeb_setup() {
  delay(1000);
  
  WiFi.softAP(ssid, password);
  IPAddress myIP = WiFi.softAPIP();

  server.on("/car/start/contact", WifiWeb_startContact);
  server.on("/car/stop/contact", WifiWeb_stopContact);
  server.on("/car/start/ignition", WifiWeb_startIgnition); //todo look for parameters
  server.on("/car/status", WifiWeb_status);

  server.begin();

  Serial.print("AP IP address: ");
  Serial.println(myIP);
}

void WifiWeb_loop() {
  server.handleClient();
}

/* 
 *  Sends a message to the arduino controller that the contact relai needs to be turned on.
 *   http://192.168.4.1:46969/car/start/contact
*/
void WifiWeb_startContact() {
  Serial.println("startContact NOW!!");
  SoftwareSerial_command_startContact();
  server.send(200, "text/html", "<h1>start contact</h1>");
}

/* 
 *  Sends a message to the arduino controller that the contact relai needs to be turned off.
 *   http://192.168.4.1:46969/car/stop/contact
*/
void WifiWeb_stopContact() {
  SoftwareSerial_command_stopContact();
  server.send(200, "text/html", "<h1>stop contact</h1>");
}

/* 
 *  Sends a message to the arduino controller that the ignition relai needs to be turned on for a specific time.
 *   http://192.168.4.1:46969/car/start/ignition?ignitionTime=1000
*/
//TODO REFACTOR THE WHOLE IF STATEMENT
void WifiWeb_startIgnition() {
  SoftwareSerial_command_startIgnition(server.arg("ignitionTime").toInt());
  String message = "";
  message += server.arg("ignitionTime");
  if(message == ""){
    server.send(400, "text/html", "<h1>couldn't connect</h1>");
  }else{
    server.send(200, "text/html", "<h1>starting with " + message + "</h1>");
  }
}

/* 
 *  Ask the arduino controller the time the engine is running
 *   http://192.168.4.1:46969/car/status
*/
void WifiWeb_status() {
  SoftwareSerial_command_status();
  server.send(200, "text/html", "<h1>status</h1>");
}
