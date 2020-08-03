import 'package:auto_flutter_app/actions/set_time/set_start_time_action.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';

final List<String> _startTimesOptions = [
    '800',
    '900',
    '1000',
    '1100',
    '1250',
    '1500',
    '1750'
  ]; //Start engine power time

class StartTimeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => _ViewModel.fromStore(
            store,  
            onStartTimeChanged: (startTime) => store.dispatch(SetStartTimeAction(startTime))
          ),
          builder: (BuildContext context, _ViewModel vm) {
            return DropdownButton(
            value: vm.selectedStartTime,
            onChanged: (newValue) => vm.onStartTimeChanged(newValue),
            items: _startTimesOptions.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
      );
    });
  }
}

class _ViewModel {
  final String selectedStartTime;

  final void Function(String startTime) onStartTimeChanged;

  _ViewModel({this.selectedStartTime, this.onStartTimeChanged});

  static _ViewModel fromStore(Store<AppState> store, {onStartTimeChanged}) {
      return _ViewModel(
        selectedStartTime: store.state.selectedStartTime,
        onStartTimeChanged: onStartTimeChanged,
      );
  }
}
