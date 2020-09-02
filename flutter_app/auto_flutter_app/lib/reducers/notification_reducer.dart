import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final notificationReducer = combineReducers<AppState>([
  TypedReducer<AppState, ShowMessage>(_throwErrorAction),
  TypedReducer<AppState, ClearMessageState>(_resolveErrorAction),
]);

AppState _throwErrorAction(AppState state, ShowMessage action) =>
    state.copyWith(error: action.error);

AppState _resolveErrorAction(AppState state, ClearMessageState action) =>
    state.copyWith(error: null);

