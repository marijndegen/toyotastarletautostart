//https://pub.dev/packages/connectivity

//import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

//const String serverPrefix = "http://192.168.4.1:46969";
const String serverPrefix = "http://192.168.5.101:80";

const String startEndpoint = "/car/start/contact";
const String stopEndpoint = "/car/stop/contact";
String ignitionEndpoint(int ignitionTime){
  return "/car/start/ignition?ignitionTime=" + ignitionTime.toString();
}
const String statusEndpoint = "/car/status";


class CarInterfaceService{

  bool polling = false;

  CarInterfaceService(){
    polling = true;
  }

  Future startContact() async {
    print("Contact on...");
    const String url = serverPrefix + startEndpoint;
    await simpleBoolHttpRequest(url);
  }

  Future stopContact() async {
    print("Contact off...");
    const String url = serverPrefix + stopEndpoint;
    await simpleBoolHttpRequest(url);
  }

  Future ignite(int igniteTime) async{
    print("Igniting...");
    final String url = serverPrefix + ignitionEndpoint(igniteTime);
    await simpleBoolHttpRequest(url);
  }

  Future<int> status() async {
    const url = serverPrefix + statusEndpoint;
    var response = await http.get(url);

    var status = -100;

    try{
      status = int.parse(response.body);
    }catch (e){
      print("Went wrong in the status catch block!");
      return status;
    }

    print(statusEndpoint + ": " + response.statusCode.toString() + " with status " + response.body);

    if (int.parse(response.body) is int && response.statusCode == 200 && status != -100) {
      return status;
    }

    return -100;
  }

  Future<bool> simpleBoolHttpRequest(String url) async {
    var response;
    try{
      response = await http.get(url).timeout(Duration(milliseconds: 2500));
      print("SBHR service: " + url);
    }catch (e){
      print("Went wrong in the simplecatch block!");
      return false;
    }
    print(url + " "+ response.statusCode.toString());

    return response.statusCode == 200;
  }

  Future sleep(int milliseconds) {
    return new Future.delayed(Duration(milliseconds: milliseconds), () {});
  }

  Stream<int> carStatusStream() async*{
    int initialStatus;
    bool connected;

    try{
      initialStatus = await this.status().timeout(Duration(milliseconds: 2500));
      connected = (initialStatus >= -2);
      if(!connected)
        throw("");
    }catch (e){
        throw("Not connected with statusStream!!");
    }

    while(connected && polling){
      await sleep(3000); //this maybe can be changed to 2500, so that there are 4 updates a second.
      yield await this.status().timeout(Duration(milliseconds: 2500));
    }
  }
}
