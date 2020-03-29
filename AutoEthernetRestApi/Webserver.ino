#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {0xD1, 0xAD, 0xBE, 0xE1, 0xFE, 0xED };
IPAddress ip(192,168,1,177); // 192.168.1.177
EthernetServer server(80);
EthernetClient client;

void Webserver_setup(){
  Ethernet.begin(mac, ip);
  Serial.begin(9600);
  server.begin();
}

void Webserver_loop(){
  Webserver_serve();
  
}

void Webserver_serve(){
  client = server.available();
  
  if (client) {
    boolean currentLineIsBlank = true;
    String request = "";
    Serial.println("New request");
    
    while (client.connected()) {
      if (client.available()) {        
        char c = client.read();
        request += c;

        if (c == '\n' && currentLineIsBlank) {
          //Serial.println(getEndpoint(request));
          endpointHandler(getEndpoint(request));
          break;
        }
        
        if (c == '\n') {
          currentLineIsBlank = true;
        } 
        else if (c != '\r') {
          currentLineIsBlank = false;
        }
      }
    }
    delay(1);
    client.stop();
  }
}

void endpointHandler(String endpoint){
  Serial.println(endpoint);
  
  if(endpoint == "/helloworld"){
    sendHelloWorldResponse();
    return;
  }

  if(endpoint == "/byeworld"){
    sendByeWorldResponse();
    return;
  }

  HTTP_sendResponse("Woops, we couldn't find that!");
}

void sendHelloWorldResponse(){
  HTTP_sendResponse("Hello world!");
}

void sendByeWorldResponse(){
  HTTP_sendResponse("Bye world!");
}

String getEndpoint(String request){
  String endPointString = "";

  bool isSkimming = true;
  bool isCounting = false;

  const String identifier = "endpoint";
  const int identifierLength = identifier.length();
  char toSkim[identifierLength];
  for(int i = 0; i < identifierLength ; i++){
    toSkim[i] = identifier[i];
  }
  char compareableSkim [identifierLength];

  //Iterate through the request.
  for(int i = 0; i < request.length(); i++){
    char c = request[i];

    //If the identifier was found, start registering the endpointString.
    if(isCounting){
      if(c != ' '){
        endPointString  += c;  
      }else{
        isCounting = false;
        isSkimming = false;
        break;
      }
    }

    //Register the string.
    if(isSkimming){
      for(int i = 0; i < identifierLength; i++){
        if(i == identifierLength - 1){
          compareableSkim[i] = c;
        }else{
          compareableSkim[i] = compareableSkim[i + 1];  
        }
      }
    }

    //Check if the registered string is possibly the endpoint string.
    for(int i = 0; i < identifierLength; i++){
      if(toSkim[i] != compareableSkim[i]){
        break;
      }else if(i == (identifierLength - 1)){
        isCounting = true;
      }
    }
  }
  
  return endPointString;
}

void HTTP_sendResponse(String response){
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/plain");
  client.println("Connection: close");
  client.println();
  client.println(response);
//  client.println("<!DOCTYPE HTML>");
//  client.println("<html>");
//  client.println("Hello world!");
//  client.println("</html>");
}
