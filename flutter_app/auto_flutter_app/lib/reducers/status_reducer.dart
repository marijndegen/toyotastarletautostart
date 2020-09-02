import 'package:auto_flutter_app/settings/settings.dart';
import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final Settings s = Settings.getCorrectSettings(); 

final statusReducer = combineReducers<AppState>([
  TypedReducer<AppState, StartListeningAction>(_startListening),
  // TypedReducer<AppState, FetchCarStatusAction>(_fetchCarStatus),
  TypedReducer<AppState, CarStatusAction>(_carStatus),
  TypedReducer<AppState, CarStatusErrorAction>(_carStatusError),
]);

//To indicate that the store is actually listening
AppState _startListening(AppState state, StartListeningAction action) =>
  state.copyWith(listening: true);

//Purely used by the middleware to keep the long polling alive. Not needed here!
// AppState _fetchCarStatus(AppState state, StartListeningAction action) =>
//   state.copyWith();

//A statusmessage returned from the middleware
AppState _carStatus(AppState state, CarStatusAction action) =>
  state.copyWith(carStatus: action.status);

//When an error occours, reset the listening variable.


//TODO anticipating on modifing the state here is not a great idea, either the message has to be included here,
// which would make the message reducer obsolete, or the counting of the number of failed request has to take place in the middleware
AppState _carStatusError(AppState state, CarStatusErrorAction action) =>
  state.failedAttempts < s.maxRetries ? 
  state.copyWith(failedAttempts: state.failedAttempts + 1) : 
  state.copyWith(listening: false, carStatus: -100); 