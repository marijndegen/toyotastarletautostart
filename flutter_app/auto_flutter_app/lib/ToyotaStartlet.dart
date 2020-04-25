import 'package:auto_flutter_app/starlet_service/car_interface.dart';
import 'package:auto_flutter_app/startlet_components/InstructionText.dart';
import 'package:auto_flutter_app/startlet_components/StatusText.dart';
import 'package:flutter/material.dart';

import 'package:get_ip/get_ip.dart';

final String appName = 'Toyota Starlet 1989';
final String appTitle = 'Toyota Startlet 1989 van Marijn';

class ToyotaStarlet extends StatefulWidget {

  final CarInterfaceService cis;

  ToyotaStarlet(this.cis);

  @override
  State<StatefulWidget> createState() => _ToyotaStarletState();
}

class _ToyotaStarletState extends State<ToyotaStarlet> {

  //Final variables
  Color _disabledColor = Colors.grey;
  Color _startColor = Colors.green;
  Color _stopColor = Colors.red;

  //State variables
  List<String> _startTimesOptions = [
    '800',
    '900',
    '1000',
    '1100',
    '1250',
    '1500',
    '1750'
  ]; //Start engine power time
  String _selectedStartTime = '1000'; //Initial value

  String ipAdress = "No IP detected";

  int _carStatus = -100;

  bool _blockUserInput = false;

  bool listening = false;

  _ToyotaStarletState(){
    getIP();

  }

  void initState(){
    super.initState();
    print("CREATING WIDGET");
    startListening();
  }

  void startListening(){
      if(!listening){
        setState(() {
          listening = true;
        });
        widget.cis.carStatusStream().listen(
                (data) {
              print('Statusint: $data');
              setState(() {
                _carStatus = data;
              });
            },
            onError: (err){
              print(err.toString());
            },
            onDone: (){
              print("Status shouldn't be done but is done..");
              setState(() {
                listening = false;
              });
            }
        );
      }
    }

  void dispose () {
    super.dispose();
    print("DISPOSING WIDGET");
    widget.cis.polling = false;
  }

  void getIP() async {
    String ipAddresS = await GetIp.ipAddress;

    setState(() {
//      print("tried to fetch ip");
      ipAdress = ipAddresS;
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(_carStatus.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          /*Text(ipAdress),*/
          InstructionText(),
          DropdownButton(
            // Not necessary for Option 1
            value: _selectedStartTime,
            onChanged: (newValue) {
              setState(() {
                _selectedStartTime = newValue;
              });
            },
            items: _startTimesOptions.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
                width: 280,
                height: 280,
                child: !_isCarRunning() && !_blockUserInput
                    ? FloatingActionButton(
                        onPressed: () async {
                          startListening();

                          //Set the state to attempting to start and put the car in contact.
                          setState(() {
                            _blockUserInput = true;
                          });

                          if(_contactOff()) {
                            await widget.cis.startContact();
                          }

                          await widget.cis.sleep(400); //Give 400MS between the moment of contact and the starting process.

                          //Attempt to start the car.
                          await widget.cis.ignite(int.parse(_selectedStartTime));

                          //Check after 3000 MS if the car started successfully.
                          await widget.cis.sleep(3000); //Give 3000MS between the moment of starting and the check if the car started successfully.

                          //Change the values, based on the outcome of the car.
                          setState(() {
                            _blockUserInput = false;
                          });
                        },
                        backgroundColor: _startColor,
                        child: Icon(
                          Icons.play_circle_filled,
                          size: 150,
                        ),
                      )
                    : _blockUserInput
                        ? FloatingActionButton(
                            onPressed: null,
                            //Nothing needs to be done, the state should be updated based on the startContact function.
                            backgroundColor: _disabledColor,
                            child: Icon(
                              Icons.stop,
                              size: 150,
                            ),
                          )
                        : _isCarRunning()
                            ? FloatingActionButton(
                                onPressed: () async {
                                  setState(() {
                                    //call the stopcontact function here.
                                    _blockUserInput = true; //NOTE THIS IS NOT ATTEMPTING, JUST TO BLOCK USER INTERACTION.
                                  });

                                  await widget.cis.stopContact();

                                  //Check after 3000 MS if the car started successfully.
                                  await widget.cis.sleep(3000); //Give 3000MS between the moment of starting and the check if the car started successfully.

                                  setState(() {
                                    //call the stopcontact function here.
                                    _blockUserInput = false; //NOTE THIS IS NOT ATTEMPTING, JUST TO BLOCK USER INTERACTION.
                                  });

                                },
                                backgroundColor: _stopColor,
                                child: Icon(
                                  Icons.stop,
                                  size: 150,
                                ),
                              )
                            : FloatingActionButton(
                                onPressed: null,
                                backgroundColor: _disabledColor,
                                child: SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: CircularProgressIndicator(),
                                ),
                              )),
          ),
          StatusText(
            blockUserInput: this._blockUserInput,
            status: this._carStatus,
          ),
        ],
      )),
    );
  }


  bool _contactOff() {
    return _carStatus == -2;
  }

  bool _isCarRunning() {
    return _carStatus >= 0;
  }
}
