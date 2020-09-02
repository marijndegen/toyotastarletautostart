import 'package:auto_flutter_app/actions/status/fetch_car_status_action.dart';
import 'package:auto_flutter_app/actions/status/start_listening_action.dart';
import 'package:auto_flutter_app/components/buttons/disabeld_button_component.dart';
import 'package:auto_flutter_app/components/buttons/disconnected_button_component.dart';
import 'package:auto_flutter_app/components/buttons/start_button_component.dart';
import 'package:auto_flutter_app/components/buttons/stop_button_component.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// final Color _disabledColor = Colors.grey;
// final Color _startColor = Colors.green;
// final Color _stopColor = Colors.red;
// final Color _disconnectedColor = Colors.blue;

class ControlButtonRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, _ViewModel>(
          onInit: (store) {
            if(!store.state.listening){
              store.dispatch(StartListeningAction());
              store.dispatch(FetchCarStatusAction());
              print("initial fetch");
            }
          },
          converter: (Store<AppState> store) => _ViewModel.fromStore(store),
          builder: (BuildContext context, _ViewModel vm) {
                return  Container(
            margin: EdgeInsets.all(15),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: SizedBox(
                width: 250,
                height: 250,
                child: 
                //TODO
                //Currently, when one packet fails, an error action is dispatched and no retry is made, it should retry once.
                (!vm.listening) ? DisconnectedButton() : 
                (vm.listening && (vm.carStatus == -2 || vm.carStatus == -1) && !vm.blockUserInput) ? StartButton() : 
                (vm.listening && (vm.carStatus > 0) && !vm.blockUserInput) ? StopButton() : DisabeldButton() 
                ), //buttons here
            );
    });
  }
}

class _ViewModel {
  final int carStatus;

  final bool blockUserInput;

  final bool listening;

  _ViewModel({this.carStatus, this.blockUserInput, this.listening, /*this.startListening, this.fetchCarStatus*/});

  static _ViewModel fromStore(Store<AppState> store, {startListening, fetchCarStatus}) {
      return _ViewModel(
        carStatus: store.state.carStatus,
        blockUserInput: store.state.blockUserInput,
        listening: store.state.listening,
      );
  }
}
