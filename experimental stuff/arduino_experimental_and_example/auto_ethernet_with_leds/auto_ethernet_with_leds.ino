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

int CONTACT_RELAY = 2;
int START_RELAY = 3;
int CONTACT_RELAY_ACTIVE = 4;
int START_RELAY_ACTIVE = 5;

byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(192,168,1,177);
EthernetServer server(80);


void setup() {
  // put your setup code here, to run once:
  pinMode(CONTACT_RELAY, OUTPUT);
  pinMode(START_RELAY , OUTPUT);
  
  pinMode(CONTACT_RELAY_ACTIVE, OUTPUT);
  pinMode(START_RELAY_ACTIVE, OUTPUT);

  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  Ethernet.begin(mac, ip);
  server.begin();
  Serial.print("server is at ");
  Serial.println(Ethernet.localIP());
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(CONTACT_RELAY, HIGH);
  digitalWrite(START_RELAY, HIGH);

  delay(2000);
  digitalWrite(CONTACT_RELAY_ACTIVE, HIGH);
  delay(2000);
  digitalWrite(START_RELAY_ACTIVE, HIGH);
  
    // listen for incoming clients
  EthernetClient client = server.available();
  if (client) {
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
          client.println("<meta http-equiv=\"refresh\" content=\"10\">");
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
