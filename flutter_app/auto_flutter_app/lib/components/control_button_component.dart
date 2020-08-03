import 'package:auto_flutter_app/actions/status/fetch_car_status_action.dart';
import 'package:auto_flutter_app/actions/status/start_listening_action.dart';
import 'package:auto_flutter_app/components/Buttons/disconnected_button_component.dart';
import 'package:auto_flutter_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

final Color _disabledColor = Colors.grey;
final Color _startColor = Colors.green;
final Color _stopColor = Colors.red;
final Color _disconnectedColor = Colors.blue;

class ControlButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, _ViewModel>(
          
          converter: (Store<AppState> store) => _ViewModel.fromStore(
            store, 
            startListening: () => store.dispatch(StartListeningAction()),
            fetchCarStatus: () => store.dispatch(FetchCarStatusAction())
          ),
          builder: (BuildContext context, _ViewModel vm) {
                return  Container(
            margin: EdgeInsets.all(15),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: SizedBox(
                width: 280,
                height: 280,
                child: 
                (!vm.listening) ? DisconnectedButton() : 
                (vm.listening && (vm.carStatus == -2 || vm.carStatus == -1) ? Text('car is ready to be started') : 
                Text('this state should probably show a blocking animation')
                ), //buttons here
            );
    });
  }
}

class _ViewModel {
  final int carStatus;

  final bool blockUserInput;

  final bool listening;

  final void Function() startListening;
  
  final void Function() fetchCarStatus;


  _ViewModel({this.carStatus, this.blockUserInput, this.listening, this.startListening, this.fetchCarStatus});

  static _ViewModel fromStore(Store<AppState> store, {startListening, fetchCarStatus}) {
      return _ViewModel(
        carStatus: store.state.carStatus,
        blockUserInput: store.state.blockUserInput,
        listening: store.state.listening,
        startListening: startListening,
        fetchCarStatus: fetchCarStatus
      );
  }
}
