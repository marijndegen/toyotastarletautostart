

import 'package:auto_flutter_app/actions/notifications/clear_message_state.dart';
import 'package:auto_flutter_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ErrorHandler extends StatelessWidget {

  final Widget child;

  const ErrorHandler({Key key, this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
                  converter: (Store<AppState> store) => _ViewModel.fromStore(store),
                  builder: (BuildContext context, _ViewModel vm) => child,
                  onWillChange: (vm) {
                    if (vm.error != null) {
                      vm.resolveError();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(vm.error.toString()),
                          duration: Duration(seconds: 7, milliseconds: 500),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            textColor: Colors.blue,
                            onPressed: () {
                              Scaffold.of(context).hideCurrentSnackBar();
                            }
                        ),

                      ));
                    }
                  },
                  distinct: true,
        );
  }
      
}

class _ViewModel {

  final Exception error;

  final Function resolveError;

  _ViewModel({this.error, this.resolveError});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      error: store.state.error,
      resolveError: () => store.dispatch(ClearMessageState()),
    );
  }

  @override
  int get hashCode => error.hashCode  ;

  @override
  bool operator ==(other) {
    return identical(this, other) || (other is _ViewModel && other.error == this.error);
  }
}
