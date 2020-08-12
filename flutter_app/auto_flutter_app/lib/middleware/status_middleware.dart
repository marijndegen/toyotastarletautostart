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
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchCarStatusAction && store.state.listening){
      String url = api + "car/status";
      
      var response;
      try{
        response = await client.get(url).timeout(
        Duration(milliseconds: 1750),
        onTimeout: () {
          client.close();
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
        store.dispatch(FetchCarStatusAction());
      } else {
        // print('error in response code');
        store.dispatch(CarStatusErrorAction());
      }
    }

    next(action);
  }
}