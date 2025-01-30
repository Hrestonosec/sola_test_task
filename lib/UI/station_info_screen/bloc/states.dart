part of 'bloc.dart';

abstract class StationInfoState {}

class StationInfoInitial extends StationInfoState {}

class StationInfoLoaded extends StationInfoState {
  final ChargingStation station;

  StationInfoLoaded(this.station);
}

class StationInfoError extends StationInfoState {
  final String message;

  StationInfoError(this.message);
}

class OpenStationLocation extends StationInfoState {}
