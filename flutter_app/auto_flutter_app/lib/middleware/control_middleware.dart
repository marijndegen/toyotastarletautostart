import 'package:auto_flutter_app/actions/block_user_input/block_user_input_action.dart';
import 'package:auto_flutter_app/actions/start_car/start_car_action.dart';
import 'package:auto_flutter_app/actions/status/car_status_action.dart';
import 'package:auto_flutter_app/actions/status/car_status_error_action.dart';
import 'package:auto_flutter_app/actions/status/fetch_car_status_action.dart';
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
      print('hallo');
      String contactUrl = api + "car/start/contact";

      String startUrl = '${api}car/start/ignition?ignitionTime=${store.state.selectedStartTime}';

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



       /*
startListening();
                //Set the state to attempting to start and put the car in contact.
                setState(() {
                  _blockUserInput = true;
                });
                if (_isContactOff()) {
                  await widget.cis.startContact();
                }
                await widget.cis.sleep(
                    400); //Give 400MS between the moment of contact and the starting process.
                //Attempt to start the car.
                await widget.cis.ignite(int.parse(_selectedStartTime));
                //Check after 3000 MS if the car started successfully.
                await widget.cis.sleep(
                    3000); //Give 3000MS between the moment of starting and the check if the car started successfully.
                //Change the values, based on the outcome of the car.
                setState(() {
                  _blockUserInput = false;
                });
                */
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

    // if(action is FetchCarStatusAction && store.state.listening){
    //   String url = api + "car/status";
      
    //   final response = await client.get(url).timeout(
    //     Duration(milliseconds: 1750),
    //     onTimeout: () {
    //       client.close();
    //       next(action);
    //       return null;
    //     },
    //   );
    //   if(response is http.Response){
    //     print('response is response');
    //   }

    //   print(response.statusCode );

    //   if (response is http.Response && response.statusCode == 200) {
    //     store.dispatch(CarStatusAction(int.tryParse(response.body) ?? -100));
    //     await Future.delayed(Duration(seconds: 2));
    //     store.dispatch(FetchCarStatusAction());
    //   } else {
    //     // print('error in response code');
    //     store.dispatch(CarStatusErrorAction());
    //   }
    // }

    next(action);
  }
}