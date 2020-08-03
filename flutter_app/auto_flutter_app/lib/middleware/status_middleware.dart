import 'package:auto_flutter_app/actions/status/car_status_action.dart';
import 'package:auto_flutter_app/actions/status/car_status_error_action.dart';
import 'package:auto_flutter_app/actions/status/fetch_car_status_action.dart';
import 'package:auto_flutter_app/state/app_state.dart';

import 'package:redux/redux.dart';

import 'package:http/http.dart' as http;

//todo statusepic in main zien te implementeren, zorgen dat de statusepic stream werkt.
class StatusMiddleware extends MiddlewareClass<AppState>{

  final http.Client client;

  final String api;

  StatusMiddleware(this.client, this.api);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if(action is FetchCarStatusAction){
      String url = api + "/car/status";
      client.get(url)
        .then((response) {
          if(response.statusCode == 200)
            store.dispatch(CarStatusAction(int.tryParse(response.body) ?? -100));
          else
            store.dispatch(CarStatusErrorAction());
          })
        .catchError((error) {
          store.dispatch(CarStatusErrorAction());
        });
    }

    next(action);
  }
}