import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final statusReducer = combineReducers<AppState>([
  TypedReducer<AppState, StartListeningAction>(_startListening),
  // TypedReducer<AppState, FetchCarStatusAction>(_fetchCarStatus),
  TypedReducer<AppState, CarStatusAction>(_carStatus),
  TypedReducer<AppState, CarStatusErrorAction>(_carStatusError),
]);

AppState _startListening(AppState state, StartListeningAction action) =>
  state.copyWith(listening: true);

AppState _carStatus(AppState state, CarStatusAction action) =>
  state.copyWith(carStatus: action.status);


AppState _carStatusError(AppState state, CarStatusErrorAction action) =>
  state.copyWith(listening: false, carStatus: -100);