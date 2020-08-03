// third-party libs
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:auto_flutter_app/reducers/app_reducer.dart';
import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/middleware/app_middleware.dart';
import 'package:http/http.dart' as http;



import 'package:auto_flutter_app/ToyotaStartlet.dart';
// import 'package:auto_flutter_app/starlet_service/car_interface.dart';
import 'package:flutter/material.dart';

/*

 */

void main() {

  // CarInterfaceService cis = new CarInterfaceService();


  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [...createAppMiddleware(http.Client()), LoggingMiddleware.printer()] //todo hiero
    );

    runApp(StoreProvider(store: store, child:
      MaterialApp(
          title: appName,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ToyotaStarlet())
      )
    );
}
