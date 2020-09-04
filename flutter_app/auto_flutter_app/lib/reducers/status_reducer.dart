import 'package:auto_flutter_app/settings/settings.dart';
import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final Settings s = Settings.getCorrectSettings(); 

final statusReducer = combineReducers<AppState>([
  TypedReducer<AppState, StartListeningAction>(_startListening),
  TypedReducer<AppState, CarStatusAction>(_carStatus),
  TypedReducer<AppState, CarStatusErrorAction>(_carStatusError),
]);

/// To indicate that the store is actually listening
AppState _startListening(AppState state, StartListeningAction action) =>
  state.copyWith(listening: true);

/// A statusmessage returned from the middleware
AppState _carStatus(AppState state, CarStatusAction action) =>
  state.copyWith(carStatus: action.status, failedAttempts: 0);

/// When an error occours, reset the listening variable.
AppState _carStatusError(AppState state, CarStatusErrorAction action) =>
  state.failedAttempts < s.maxRetries ? 
  state.copyWith(failedAttempts: state.failedAttempts + 1) :
  state.copyWith(listening: false, error: Exception("Check your wifi connection"), failedAttempts: 0, carStatus: -100);