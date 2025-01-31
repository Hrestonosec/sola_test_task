part of 'bloc.dart';

abstract class HomeScreenEvent {}

class FetchStationsEvent extends HomeScreenEvent {}

class ToggleFavoriteEvent extends HomeScreenEvent {
  final String stationId;
  ToggleFavoriteEvent(this.stationId);
}
