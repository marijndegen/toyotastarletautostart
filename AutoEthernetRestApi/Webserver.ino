#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {0xD1, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
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

    String response = "";

    bool isCounting = false;
    int fetchNumber = 3;
    String chars = "";
    
    const int idLength = 3;    
    char skimming [idLength] = {'*', '*', '*'}; 

    Serial.println("New request");
    
    while (client.connected()) {

      
      if (client.available()) {

        
        char c = client.read();
        response += c;
        
        //Trying to fetch the endpoint.
        if(isCounting){
          chars += c;
          fetchNumber--;
          if(fetchNumber == 0){
            isCounting = false;
          }
        }
        
        skimming[0] = skimming[1];
        skimming[1] = skimming[2];
        skimming[2] = c;

        bool skimmingCool = true;
        if(skimming[0] == 'c' && skimming[1] == 'c' && skimming[2] == 'c'){
          isCounting = true;
          Serial.println("hallo");
        }

        

        //breaking out of the loop and sending the request.
        if (c == '\n' && currentLineIsBlank) {
          Serial.println("answer is: ");
          Serial.println(chars);
          HTTP_sendResponse();
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
    //Serial.println("client disonnected");
  }
}

void HTTP_sendResponse(){
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println("Connection: close");
  client.println();
  client.println("<!DOCTYPE HTML>");
  client.println("<html>");
  client.println("Hello world!");
  client.println("</html>");
}

String HTTP_getEndpoint(String request){
  
}
