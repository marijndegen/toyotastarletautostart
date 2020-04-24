#include <ESP8266WiFi.h>            
#include <ESP8266WebServer.h>

ESP8266WebServer server(80);   //Web server object. Will be listening in port 80 (default for HTTP)

/*
 * NOTE THAT THE IP ADDRESS MAY VARRY
 * when this url is queried: 
 * http://192.168.5.102/genericArgs?ignitionTime=234
 * 
 * this should be the result
 * Arg number 0 -> ignitionTime: 234
 * 234
 * 
 */
void handleGenericArgs() {
  String message = "";
  for (int i = 0; i < server.args(); i++) {
    message += "Arg number " + (String)i + " -> ";
    message += server.argName(i) + ": ";
    message += server.arg(i) + "\n";
  } 
  message += server.arg("ignitionTime");
  server.send(200, "text/plain", message);
}

void setup() {

Serial.begin(115200);
WiFi.begin("HouseHoldDegen", "aabbccddee"); //Connect to the WiFi network

while (WiFi.status() != WL_CONNECTED) { //Wait for connection

delay(500);
Serial.println("Waiting to connect…");

}

Serial.print("IP address: ");
Serial.println(WiFi.localIP());  //Print the local IP to access the server

server.on("/genericArgs", handleGenericArgs); //Associate the handler function to the path
//server.on("/specificArgs", handleSpecificArg);   //Associate the handler function to the path

server.begin();                                       //Start the server
Serial.println("Server listening");   

}

void loop() {

server.handleClient();    //Handling of incoming requests

}
