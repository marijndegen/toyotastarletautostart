import 'package:auto_flutter_app/state/app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:http/http.dart' as http;

//todo statusepic in main zien te implementeren, zorgen dat de statusepic stream werkt.
class StatusEpic implements EpicClass<AppState> {
  final http.Client client;

  StatusEpic(this.client);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    
  }


}