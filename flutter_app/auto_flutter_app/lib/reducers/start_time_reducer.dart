import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final startTimeReducer = combineReducers<AppState>([
  TypedReducer<AppState, SetStartTimeAction>(_setStartTimeAction),
]);

AppState _setStartTimeAction(AppState state, SetStartTimeAction action) =>
    state.copyWith(selectedStartTime: action.startTime);