import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// import 'package:auto_flutter_app/starlet_service/car_interface.dart';
import 'package:auto_flutter_app/components/InstructionText.dart';
import 'package:auto_flutter_app/components/StartTimeSelector.dart';

import 'package:auto_flutter_app/components/StatusText.dart';

import 'package:auto_flutter_app/state/app_state.dart';
// import 'package:get_ip/get_ip.dart';

final String appName = 'Toyota Starlet 1989';
final String appTitle = 'Toyota Startlet 1989 van Marijn';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> _startTimesOptions = [
    '800',
    '900',
    '1000',
    '1100',
    '1250',
    '1500',
    '1750'
  ]; //Start engine power time

final Color _disabledColor = Colors.grey;
final Color _startColor = Colors.green;
final Color _stopColor = Colors.red;
final Color _disconnectedColor = Colors.blue;

class ToyotaStarlet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO CREATE VIEWMODEL, ADJUST VARIABLES AND DISPATCH ACTIONS.
      return StoreConnector<AppState, _ViewModel>(
              converter: (Store<AppState> store) => _ViewModel.fromStore(store),
              builder: (BuildContext context, _ViewModel vm) {
              return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: Column(
            children: <Widget>[
            InstructionText(),
            StartTimeSelector(),
            //ControlButton(),
            //StatusText() //TODO should consume blockuserInput and the status of the car.


        // DropdownButton(
        //   // Not necessary for Option 1
        //   value: "1000",
        //   onChanged: (newValue) {
        //     //TODO DISPATCH THE ACTION
        //   },
        //   items: _startTimesOptions.map((location) {
        //     return DropdownMenuItem(
        //       child: new Text(location),
        //       value: location,
        //     );
        //   }).toList(),
        // ),
      //   Container(
      //       margin: EdgeInsets.all(15),
      //       width: MediaQuery
      //           .of(context)
      //           .size
      //           .width,
      //       child: SizedBox(
      //           width: 280,
      //           height: 280,
      //           child: FloatingActionButton(
      //         onPressed: () => {},
      //         backgroundColor: _disconnectedColor,
      //         child: Icon(
      //           Icons.signal_cellular_connected_no_internet_4_bar,
      //           size: 150,
      //         ),
      //       )),
      // ),
      // StatusText(
      //   blockUserInput: false,
      //   status: -2,
      // ),
      ],
    )),


    //todo make action of floating action button.
    //Should only be issued when the contact is on.
    // floatingActionButton: _listening && _isContactOn() ?
    //     FloatingActionButton(
    //       onPressed: _blockUserInput ? null : () => _stopContact(),
    //       backgroundColor: _stopColor,
    //       child: Center(
    //         child: Icon(Icons.highlight_off)
    //       ),
    //     ) :
    //     null
    );
			}
    );
  }
}

class _ViewModel {
  // final bool someVar;

  // _ViewModel(
  //     {this.someVar});

  // static _ViewModel fromStore(Store<AppState> store) {
  //   return _ViewModel(
  //     someVar: store.state.someVar
  //   );
  // }

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      
    );
  }
}

// class ToyotaStarlet extends StatefulWidget {

//   final CarInterfaceService cis;

//   ToyotaStarlet(this.cis);

//   @override
//   State<StatefulWidget> createState() => _ToyotaStarletState();
// }

// class _ToyotaStarletState extends State<ToyotaStarlet> {

//   //Final variables
//   Color _disabledColor = Colors.grey;
//   Color _startColor = Colors.green;
//   Color _stopColor = Colors.red;
//   Color _disconnectedColor = Colors.blue;

//   //State variables
//   List<String> _startTimesOptions = [
//     '800',
//     '900',
//     '1000',
//     '1100',
//     '1250',
//     '1500',
//     '1750'
//   ]; //Start engine power time
//   String _selectedStartTime = '1000'; //Initial value

//   String ipAdress = "No IP detected";

//   int _carStatus = -100;

//   bool _blockUserInput = false;

//   bool _listening = false;

//   _ToyotaStarletState() {
//     getIP();
//   }

//   void initState() {
//     super.initState();
//     print("CREATING WIDGET");
//     startListening();
//   }

//   void startListening() {
//     if (!_listening) {
//       widget.cis.carStatusStream().listen(
//               (data) {
//             print('Statusint: $data');
//             setState(() {
//               _carStatus = data;
//               _listening = true;
//             });
//           },
//           onError: (err) {
//             print(err.toString());
//           },
//           onDone: () {
//             print("Status shouldn't be done but is done..");
//             setState(() {
//               _listening = false;
//             });

//             _scaffoldKey.currentState.showSnackBar(
//                 SnackBar(
//                   content: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Text("Error, couln't connect with the wifi chip."),
//                       IconButton(
//                           icon: Icon(Icons.do_not_disturb),
//                           onPressed: () {
//                             _scaffoldKey.currentState.hideCurrentSnackBar();
//                           }
//                       ),
//                     ],
//                   ),
//                   duration: Duration(seconds: 10),

//                 )
//             );
//           }
//       );
//     }
//   }

//   void dispose() {
//     super.dispose();
//     print("DISPOSING WIDGET");
//     widget.cis.polling = false;
//   }

//   void getIP() async {
//     String ipAddresS = await GetIp.ipAddress;

//     setState(() {
// //      print("tried to fetch ip");
//       ipAdress = ipAddresS;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
// //    print(_carStatus.toString());
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(appTitle),
//       ),
//       body: Center(
//         child: Column(
//             children: <Widget>[
//             /*Text(ipAdress),*/
//             InstructionText(),
//         DropdownButton(
//           // Not necessary for Option 1
//           value: _selectedStartTime,
//           onChanged: (newValue) {
//             setState(() {
//               _selectedStartTime = newValue;
//             });
//           },
//           items: _startTimesOptions.map((location) {
//             return DropdownMenuItem(
//               child: new Text(location),
//               value: location,
//             );
//           }).toList(),
//         ),
//         Container(
//             margin: EdgeInsets.all(15),
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//             child: SizedBox(
//                 width: 280,
//                 height: 280,
//                 child: !_listening
//                 ? FloatingActionButton(
//               onPressed: () => startListening(),
//               backgroundColor: _disconnectedColor,
//               child: Icon(
//                 Icons.signal_cellular_connected_no_internet_4_bar,
//                 size: 150,
//               ),
//             ) : !_isCarRunning() && !_blockUserInput
//                 ? FloatingActionButton(
//               onPressed: () async {
//                 startListening();

//                 //Set the state to attempting to start and put the car in contact.
//                 setState(() {
//                   _blockUserInput = true;
//                 });

//                 if (_isContactOff()) {
//                   await widget.cis.startContact();
//                 }

//                 await widget.cis.sleep(
//                     400); //Give 400MS between the moment of contact and the starting process.

//                 //Attempt to start the car.
//                 await widget.cis.ignite(int.parse(_selectedStartTime));

//                 //Check after 3000 MS if the car started successfully.
//                 await widget.cis.sleep(
//                     3000); //Give 3000MS between the moment of starting and the check if the car started successfully.

//                 //Change the values, based on the outcome of the car.
//                 setState(() {
//                   _blockUserInput = false;
//                 });
//               },
//               backgroundColor: _startColor,
//               child: Icon(
//                 Icons.play_circle_filled,
//                 size: 150,
//               ),
//             )
//                 : _blockUserInput
//                 ? FloatingActionButton(
//               onPressed: null,
//               backgroundColor: _disabledColor,
//               child: Icon(
//                 Icons.stop,
//                 size: 150,
//               ),
//             )
//                 : _isCarRunning()
//                 ? FloatingActionButton(
//               onPressed: () => _stopContact(),
//               backgroundColor: _stopColor,
//               child: Icon(
//                 Icons.stop,
//                 size: 150,
//               ),
//             )
//                 : FloatingActionButton(
//               onPressed: null,
//               backgroundColor: _disabledColor,
//               child: SizedBox(
//                 width: 150,
//                 height: 150,
//                 child: CircularProgressIndicator(),
//               ),
//             )),
//       ),
//       StatusText(
//         blockUserInput: this._blockUserInput,
//         status: this._carStatus,
//       ),
//       ],
//     )),

//     //Should only be issued when the contact is on.
//     floatingActionButton: _listening && _isContactOn() ?
//         FloatingActionButton(
//           onPressed: _blockUserInput ? null : () => _stopContact(),
//           backgroundColor: _stopColor,
//           child: Center(
//             child: Icon(Icons.highlight_off)
//           ),
//         ) :
//         null
//     );
//   }

//   void _stopContact () async {
//     setState(() {
//       _blockUserInput = true;
//     });

//     await widget.cis.stopContact();

//     await widget.cis.sleep(3000);

//     setState(() {
//       _blockUserInput = false;
//     });
//   }


//   bool _isContactOff() {
//     return _carStatus == -2;
//   }

//   bool _isContactOn(){
//     return _carStatus == -1;
//   }

//   bool _isCarRunning() {
//     return _carStatus >= 0;
//   }
// }
