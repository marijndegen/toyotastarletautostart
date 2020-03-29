/*
 * Uitvoer plan: 
 * - Eerst enkel met ethernet, een pc en de relays de auto laten starten
 * - Wanneer beschikbaar, de wifi module hiervoor gebruiken, eventueel via een cli
 * - Een app maken voor de telefoon om de rest request te versturen
 * - De auto zo inrichten dat alle apparatuur goed is
 * - eventueel, via google assistant de auto starten.
 */

#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192,168,1,177);
EthernetServer server(80);

bool started = false;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  Ethernet.begin(mac, ip);
  server.begin();
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());

  pinMode(6, OUTPUT); //Start engine
  pinMode(7, OUTPUT); // Other stuff 
}

void loop() {
  // put your main code here, to run repeatedly:
  
  // listen for incoming clients
  EthernetClient client = server.available();
  if (client) {

    if(!started){
      Serial.println("start");
      started = true;
      digitalWrite(7, HIGH);
      delay(2500);
      digitalWrite(3, HIGH);
      delay(1000); //1750 winter, ca. 1350 normaal
      digitalWrite(4, LOW);
    }else{
      Serial.println("stop");
      started = false;
      digitalWrite(7, LOW);
    }
    
    Serial.println("new client");
    // an http request ends with a blank line
    boolean currentLineIsBlank = true;
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        Serial.write(c);
        // if you've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so you can send a reply
        if (c == '\n' && currentLineIsBlank) {
          // send a standard http response header
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/html");
          client.println("Connection: close");
          client.println();
          client.println("<!DOCTYPE HTML>");
          client.println("<html>");
          // add a meta refresh tag, so the browser pulls again every 5 seconds:
          //client.println("<meta http-equiv=\"refresh\" content=\"10\">");
          // output the value of each analog input pin
          for (int analogChannel = 0; analogChannel < 6; analogChannel++) {
            int sensorReading = analogRead(analogChannel);
            client.print("analog input ");
            client.print(analogChannel);
            client.print(" is ");
            client.print(sensorReading);
            client.println("<br />");       
          }
          client.println("</html>");
          break;
        }
        if (c == '\n') {
          // you're starting a new line
          currentLineIsBlank = true;
        } 
        else if (c != '\r') {
          // you've gotten a character on the current line
          currentLineIsBlank = false;
        }
      }
    }
    // give the web browser time to receive the data
    delay(1);
    // close the connection:
    client.stop();
    Serial.println("client disonnected");
  }
}
