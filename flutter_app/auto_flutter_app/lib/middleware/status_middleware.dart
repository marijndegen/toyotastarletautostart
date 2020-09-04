import 'package:auto_flutter_app/actions/status/car_status_action.dart';
import 'package:auto_flutter_app/actions/status/car_status_error_action.dart';
import 'package:auto_flutter_app/actions/status/fetch_car_status_action.dart';
import 'package:auto_flutter_app/settings/settings.dart';
import 'package:auto_flutter_app/state/app_state.dart';

import 'package:redux/redux.dart';

import 'package:http/http.dart' as http;

class StatusMiddleware extends MiddlewareClass<AppState>{

  final http.Client client;

  final Settings s;

  StatusMiddleware(this.client, this.s);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchCarStatusAction && store.state.listening){
      String url = s.api + "car/status";
      
      var response;
      try{
        response = await client.get(url).timeout(
        Duration(milliseconds: 1750),
        onTimeout: () {
          next(action);
          return null;
          },
        );
      } catch (e) {
        store.dispatch(CarStatusErrorAction());
      }

      if (response is http.Response && response.statusCode == 200) {
        store.dispatch(CarStatusAction(int.tryParse(response.body) ?? -100));
        await Future.delayed(Duration(seconds: 2));
      } else {
        store.dispatch(CarStatusErrorAction());
      }

      await Future.delayed(Duration(milliseconds: 3)); //Originial setting was 3000

      store.dispatch(FetchCarStatusAction());
    }

    next(action);
  }
}