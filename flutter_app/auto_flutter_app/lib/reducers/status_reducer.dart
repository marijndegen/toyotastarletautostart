import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final statusReducer = combineReducers<AppState>([
  TypedReducer<AppState, StartListeningAction>(_startListening),
  TypedReducer<AppState, FetchCarStatusAction>(_fetchCarStatus),
  TypedReducer<AppState, CarStatusAction>(_carStatus),
  TypedReducer<AppState, CarStatusErrorAction>(_carStatusError),
]);

AppState _startListening(AppState state, StartListeningAction action) =>
  state.copyWith(listening: true);

AppState _fetchCarStatus(AppState state, FetchCarStatusAction action) {
    throw UnimplementedError();
}

AppState _carStatus(AppState state, CarStatusAction action) {
    throw UnimplementedError();
}

AppState _carStatusError(AppState state, CarStatusErrorAction action) {
    throw UnimplementedError();
}