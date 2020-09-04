import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final notificationReducer = combineReducers<AppState>([
  TypedReducer<AppState, ClearMessageState>(_resolveErrorAction),
]);

AppState _resolveErrorAction(AppState state, ClearMessageState action) =>
    state.copyWith(error: null);
