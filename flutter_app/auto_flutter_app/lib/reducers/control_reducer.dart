import 'package:redux/redux.dart';

import 'package:auto_flutter_app/state/app_state.dart';
import 'package:auto_flutter_app/actions/.actions.dart';

final controlReducer = combineReducers<AppState>([
  TypedReducer<AppState, BlockUserInputAction>(_blockUserInput),
]);

AppState _blockUserInput(AppState state, BlockUserInputAction action) =>
    state.copyWith(blockUserInput: action.block);
