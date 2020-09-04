import 'package:meta/meta.dart';

//Put all variables of toyotastarlet in appstate
@immutable
class AppState{

  final String selectedStartTime;

  final String ipAdress;

  final int carStatus;

  final bool blockUserInput;

  final bool listening;

  final int failedAttempts;

  final Exception error;

  const AppState({this.selectedStartTime, this.ipAdress, this.carStatus, this.blockUserInput, this.listening, this.failedAttempts, this.error,});

  static AppState initial() {
    return AppState(
      selectedStartTime: "1000",
      ipAdress: "No IP detected",
      carStatus: -100,
      blockUserInput: false,
      listening: false,
      failedAttempts: 0,
      error: null,
    );
  }

  AppState copyWith(
      {String selectedStartTime,
      String ipAdress,
      int carStatus,
      bool blockUserInput,
      bool listening,
      int failedAttempts,
      Exception error,}
    ) {
    return AppState(
      selectedStartTime: selectedStartTime ?? this.selectedStartTime,
      ipAdress: ipAdress ?? this.ipAdress,
      carStatus: carStatus ?? this.carStatus,
      blockUserInput: blockUserInput ?? this.blockUserInput,
      listening: listening ?? this.listening,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      error: error ?? this.error,
    );
  }

}