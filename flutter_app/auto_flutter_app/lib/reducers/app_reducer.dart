import 'package:redux/redux.dart';
import 'package:auto_flutter_app/state/app_state.dart';

import 'start_time_reducer.dart';
import 'control_reducer.dart';
import 'status_reducer.dart';
import 'error_reducer.dart';

final appReducer = combineReducers<AppState>([
  startTimeReducer,
  statusReducer,
  controlReducer,
  errorReducer,
]);