import 'package:meta/meta.dart';


//Put all variables of toyotastarlet in appstate
@immutable
class AppState{

  final int selectedStartTime;

  final String ipAdress;

  final int carStatus;

  final bool blockUserInput;

  final bool listening;

  const AppState({this.selectedStartTime, this.ipAdress, this.carStatus, this.blockUserInput, this.listening});

  static AppState initial() {
    return AppState(
      selectedStartTime: 1000,
      ipAdress: "No IP detected",
      carStatus: -100,
      blockUserInput: false,
      listening: false,
    );
  }

  AppState copyWith(
      {int selectedStartTime,
      String ipAdress,
      int carStatus,
      bool blockUserInput,
      bool listening,}
    ) {
    return AppState(
      selectedStartTime: selectedStartTime ?? this.selectedStartTime,
      ipAdress: ipAdress ?? this.ipAdress,
      carStatus: carStatus ?? this.carStatus,
      blockUserInput: blockUserInput ?? this.blockUserInput,
      listening: listening ?? this.listening,
    );
  }

}