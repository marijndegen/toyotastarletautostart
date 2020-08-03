import 'dart:async';

import 'package:auto_flutter_app/actions/.actions.dart';
import 'package:auto_flutter_app/components/Buttons/control_button.dart';
import 'package:auto_flutter_app/components/Buttons/control_view_model.dart';
import 'package:auto_flutter_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final Color _startColor = Colors.green;

class StartButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ControlViewModel>(
          converter: (Store<AppState> store) => ControlViewModel.withExecuteFunction(
            () { store.dispatch(BlockUserInputAction(true)); store.dispatch(StartCarAction());} //create dispatch function here, copy this file to every corosponding button (except disabled button.) 
          ),
          builder: (BuildContext context, ControlViewModel vm) => 
           ControlButton(vm: vm, color: _startColor, icon: Icons.play_circle_filled)
          );
  }
  
}
