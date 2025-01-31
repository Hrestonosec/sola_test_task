part of 'bloc.dart';

abstract class HomeScreenState {}

class ChargeStationsLoading extends HomeScreenState {}

class ChargeStationsLoaded extends HomeScreenState {
  final List<ChargingStation> stations;
  ChargeStationsLoaded(this.stations);
}

class ChargeStationsError extends HomeScreenState {
  final String message;
  ChargeStationsError(this.message);
}
