import 'package:flutter/material.dart';

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



    //todo commit to git on a seperate branch and import redux, appstate, create function that dispatches setstarttimeaction.
    return StoreConnector<AppState, _ViewModel>(
              converter: (Store<AppState> store) => _ViewModel.fromStore(store),
              builder: (BuildContext context, _ViewModel vm) {
                return DropdownButton(
          // Not necessary for Option 1
          value: "1000",
          onChanged: (newValue) {
            //TODO DISPATCH THE ACTION
          },
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