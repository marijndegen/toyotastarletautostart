import 'dart:async';

import 'package:auto_flutter_app/actions/status/start_listening_action.dart';
import 'package:auto_flutter_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final Color _disconnectedColor = Colors.blue;

class DisconnectedButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => _ViewModel.withExecuteFunction(
            () => store.dispatch(StartListeningAction()) //create dispatch function here, copy this file to every corosponding button (except disabled button.) 
          ),
          builder: (BuildContext context, _ViewModel vm) {
              return FloatingActionButton(
              onPressed: () {
                vm.executeButtonFuction();
              },
              backgroundColor: _disconnectedColor,
              child: Icon(
                Icons.play_circle_filled,
                size: 150,
              ),
            );   
          });
  }
  
}

class _ViewModel {
  final void Function() executeButtonFuction;

  _ViewModel(this.executeButtonFuction);

  static _ViewModel withExecuteFunction(executeButtonFuction) {
      return _ViewModel(
        executeButtonFuction
      );
  }
}