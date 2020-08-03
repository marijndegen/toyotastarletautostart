import 'dart:async';

import 'package:auto_flutter_app/actions/.actions.dart';
import 'package:auto_flutter_app/components/Buttons/control_button.dart';
import 'package:auto_flutter_app/components/Buttons/control_view_model.dart';
import 'package:auto_flutter_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final Color _disconnectedColor = Colors.blue;

class DisconnectedButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ControlViewModel>(
          converter: (Store<AppState> store) => ControlViewModel.withExecuteFunction(
            () { store.dispatch(StartListeningAction()); store.dispatch(FetchCarStatusAction()); } 
          ),
          builder: (BuildContext context, ControlViewModel vm) =>
            ControlButton(vm: vm, color: _disconnectedColor, icon: Icons.signal_cellular_connected_no_internet_4_bar)
          );
  }
  
}
