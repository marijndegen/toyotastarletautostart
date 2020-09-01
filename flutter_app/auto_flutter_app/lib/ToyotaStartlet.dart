//Packages
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:get_ip/get_ip.dart';

//Components
import 'package:auto_flutter_app/components/instruction_text_component.dart';
import 'package:auto_flutter_app/components/start_time_selector_component.dart';
import 'package:auto_flutter_app/components/control_button_router_component.dart';
import 'package:auto_flutter_app/components/status_text_component.dart';

import 'package:auto_flutter_app/state/app_state.dart';

//Actions
import 'actions/block_user_input/block_user_input_action.dart';
import 'actions/stop_car/stop_car_action.dart';

//Vars
final Color _stopColor = Colors.red;
final String appName = 'Degen start';
final String appTitle = 'Toyota Startlet 1989 van Marijn';
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class ToyotaStarlet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      
      return StoreConnector<AppState, _ViewModel>(
              converter: (Store<AppState> store) => _ViewModel.fromStore(store, () { store.dispatch(BlockUserInputAction(true)); store.dispatch(StopCarAction());}),
              builder: (BuildContext context, _ViewModel vm) {
              return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: OrientationBuilder(
          builder: (context, orientation) {
          return orientation == Orientation.portrait 
            ? Column(
                    children: <Widget>[
                    InstructionText(),
                    StartTimeSelector(),
                    ControlButtonRouter(),
                    StatusText(blockUserInput: vm.blockUserInput, carStatus: vm.carStatus,)
              ],
            ) : 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                    Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      InstructionText(),
                      StartTimeSelector(),
                      StatusText(blockUserInput: vm.blockUserInput, carStatus: vm.carStatus,)
                    ],),),
                    Expanded(
                      child: Column(
                      children: <Widget>[
                      ControlButtonRouter(),
                    ],)
                    ),
              ],
            );
           }
          ),

    //this action button works, but has no place in the frontend, leaving this in here for functionality purposes if desired.
    // floatingActionButton: vm.listening && vm.carStatus == -1 ?
    //     FloatingActionButton(
    //       onPressed: vm.blockUserInput ? null : vm.stopCar,
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

  final bool listening;

  final bool blockUserInput;

  final int carStatus;

  final Function stopCar;

  _ViewModel({this.listening, this.blockUserInput, this.carStatus, this.stopCar});

  static _ViewModel fromStore(Store<AppState> store, stopCar) {
    return _ViewModel(
      listening: store.state.listening,
      blockUserInput: store.state.blockUserInput,
      carStatus: store.state.carStatus,
      stopCar: stopCar
    );
  }
}

