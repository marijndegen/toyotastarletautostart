/*
 * Files
 * 
 * AutoEthernetRestApiMain.ino
 * AutoEthernetRestApi.ino
 * Webserver.ino
 * Webserverhttp.ino
 * CarInterface.ino
 * 
 */

void AutoEthernetRestApi_setup() {
  Webserver_setup();
  CarInterface_setup();
}

void AutoEthernetRestApi_loop() {
  Webserver_loop();
}
