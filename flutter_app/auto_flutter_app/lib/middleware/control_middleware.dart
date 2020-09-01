import 'package:auto_flutter_app/actions/block_user_input/block_user_input_action.dart';
import 'package:auto_flutter_app/actions/start_car/start_car_action.dart';
import 'package:auto_flutter_app/actions/stop_car/stop_car_action.dart';
import 'package:auto_flutter_app/state/app_state.dart';

import 'package:redux/redux.dart';

import 'package:http/http.dart' as http;

//todo statusepic in main zien te implementeren, zorgen dat de statusepic stream werkt.
class ControlMiddleware extends MiddlewareClass<AppState>{

  final http.Client client;

  final String api;

  ControlMiddleware(this.client, this.api);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {

    if(action is StartCarAction){
      String contactUrl = api + "car/start/contact";

      String startUrl = api + 'car/start/ignition?ignitionTime=' + store.state.selectedStartTime;

      //if the car is not on contact, put the car on contact
      if(store.state.carStatus == -2){
        await client.get(contactUrl).timeout(
          Duration(milliseconds: 1750),
          onTimeout: () {
            client.close();
            next(action);
            return null;
        });

        await Future.delayed(Duration(milliseconds: 400));
      }

      await client.get(startUrl).timeout(
        Duration(milliseconds: 1750),
        onTimeout: () {
          client.close();
          next(action);
          return null;
      });

      await Future.delayed(Duration(milliseconds: 1750)); //Originial setting was 3000

      store.dispatch(BlockUserInputAction(false));
    }

    if(action is StopCarAction){
      String stopUrl = api + "car/stop/contact";

      await client.get(stopUrl).timeout(
        Duration(milliseconds: 1750),
        onTimeout: () {
          client.close();
          next(action);
          return null;
      });

      await Future.delayed(Duration(milliseconds: 1750)); //Originial setting was 3000

      store.dispatch(BlockUserInputAction(false));
    }

    next(action);
  }
}