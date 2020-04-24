/*
   Copyright (c) 2015, Majenko Technologies
   All rights reserved.
   Redistribution and use in source and binary forms, with or without modification,
   are permitted provided that the following conditions are met:
 * * Redistributions of source code must retain the above copyright notice, this
     list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this
     list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.
 * * Neither the name of Majenko Technologies nor the names of its
     contributors may be used to endorse or promote products derived from
     this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
   ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
   ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/* Create a WiFi access point and provide a web server on it. */

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

#ifndef APSSID
#define APSSID "ESPap"
#define APPSK  "thereisnospoon"
#endif

/* Set these to your desired credentials. */
const char *ssid = APSSID;
const char *password = APPSK;

ESP8266WebServer server(80);

/* 
 *  Sends a message to the arduino controller that the contact relai needs to be turned on.
 *   http://192.168.4.1/car/start/contact
*/
void WifiModule_startContact() {
  server.send(200, "text/html", "<h1>start contact</h1>");
}

/* 
 *  Sends a message to the arduino controller that the contact relai needs to be turned off.
 *   http://192.168.4.1/car/stop/contact/
*/
void WifiModule_stopContact() {
  server.send(200, "text/html", "<h1>stop contact</h1>");
}

/* 
 *  Sends a message to the arduino controller that the ignition relai needs to be turned on for a specific time.
 *   http://192.168.4.1/car/start/ignition?ignitionTime=1000
*/
void WifiModule_startIgnition() {
  String message = "";
  message += server.arg("ignitionTime");
  if(message == ""){
    server.send(400, "text/html", "<h1>couldn't connect</h1>");
  }else{
    server.send(200, "text/html", "<h1>" + message + "</h1>");
  }
}

/* 
 *  Ask the arduino controller the time the engine is running
 *   http://192.168.4.1/car/status/
*/
void WifiModule_status() {
  server.send(200, "text/html", "<h1>status 2000 ms</h1>");
}

void setup() {
  delay(1000);
  Serial.begin(115200);
  Serial.println();
  Serial.print("Configuring access point...");
  /* You can remove the password parameter if you want the AP to be open. */
  WiFi.softAP(ssid, password);

  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
  
  server.on("/car/start/contact", WifiModule_startContact);
  server.on("/car/stop/contact", WifiModule_stopContact);
  server.on("/car/start/ignition", WifiModule_startIgnition); //todo look for parameters
  server.on("/car/status", WifiModule_status);
  
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}
