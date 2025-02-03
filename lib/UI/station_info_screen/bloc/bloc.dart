import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/charging_station.dart';

part 'states.dart';
part 'events.dart';

class StationInfoBloc extends Bloc<StationInfoEvent, StationInfoState> {
  StationInfoBloc() : super(StationInfoInitial()) {
    on<GetStationInfo>(_onGetStationInfo);
    on<ToggleFavoriteEvent>(_onToggleFavoriteEvent);
    on<GetStationLocation>(_onOpenMap);
  }

  // Завантажуємо станцію за її ID
  Future<void> _onGetStationInfo(
      GetStationInfo event, Emitter<StationInfoState> emit) async {
    try {
      // Завантажуємо станцію з Hive
      final box = await Hive.openBox<ChargingStation>('session_stations');
      final station = box.get(event.stationId);

      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = prefs.getStringList('favorite_stations') ?? [];

      if (station == null) {
        emit(StationInfoError("Station not found"));
        return;
      }

      if (favoriteIds.contains(event.stationId)) {
        final favoriteStation = station.copyWith(favorite: true);
        emit(StationInfoLoaded(favoriteStation));
      } else {
        emit(StationInfoLoaded(station));
      }
    } catch (e) {
      emit(StationInfoError("Error loading station"));
    }
  }

  void _onToggleFavoriteEvent(
    ToggleFavoriteEvent event,
    Emitter<StationInfoState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_stations') ?? [];

    if (state is StationInfoLoaded) {
      final currentState = state as StationInfoLoaded;
      final updatedStation = currentState.station.copyWith(
        favorite: !currentState.station.favorite, // Зміна тільки цього поля
      );

      if (favoriteIds.contains(event.stationId)) {
        favoriteIds.remove(event.stationId);
      } else {
        favoriteIds.add(event.stationId);
      }

      await prefs.setStringList('favorite_stations', favoriteIds);

      emit(StationInfoLoaded(
          updatedStation)); // Оновлюємо StationInfoLoaded замість нового стану
    }
  }

  Future<void> _onOpenMap(
      GetStationLocation event, Emitter<StationInfoState> emit) async {
    emit(OpenStationLocation());
  }
}
