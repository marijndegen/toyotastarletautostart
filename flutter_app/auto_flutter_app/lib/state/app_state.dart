import 'package:meta/meta.dart';


//Put all variables of toyotastarlet in appstate
@immutable
class AppState{

  final String selectedStartTime;

  final String ipAdress;

  final int carStatus;

  final bool blockUserInput;

  final bool listening;

  final String error;

  const AppState({this.selectedStartTime, this.ipAdress, this.carStatus, this.blockUserInput, this.listening, this.error,});

  static AppState initial() {
    return AppState(
      selectedStartTime: "1000",
      ipAdress: "No IP detected",
      carStatus: -100,
      blockUserInput: false,
      listening: false,
      error: null,
    );
  }

  AppState copyWith(
      {String selectedStartTime,
      String ipAdress,
      int carStatus,
      bool blockUserInput,
      bool listening,
      String error,}
    ) {
    return AppState(
      selectedStartTime: selectedStartTime ?? this.selectedStartTime,
      ipAdress: ipAdress ?? this.ipAdress,
      carStatus: carStatus ?? this.carStatus,
      blockUserInput: blockUserInput ?? this.blockUserInput,
      listening: listening ?? this.listening,
      error: error ?? this.error,
    );
  }

}