part of 'bloc.dart';

abstract class StationInfoEvent {}

class GetStationInfo extends StationInfoEvent {
  final String stationId;
  GetStationInfo(this.stationId);
}

class ToggleFavoriteEvent extends StationInfoEvent {
  final String stationId;
  ToggleFavoriteEvent(this.stationId);
}

class GetStationLocation extends StationInfoEvent {
  GetStationLocation();
}
