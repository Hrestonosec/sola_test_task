import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

import '../../../models/charging_station.dart';
import '../../../services/charge_stations_service.dart';

part 'states.dart';
part 'events.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ChargeStationsService _service;

  HomeScreenBloc(this._service) : super(ChargeStationsLoading()) {
    on<FetchStationsEvent>(_onFetchStationsEvent);
    on<ToggleFavoriteEvent>(_onToggleFavoriteEvent);
  }

  Future<void> _onFetchStationsEvent(
    FetchStationsEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(ChargeStationsLoading());
    try {
      final stations = await _service.fetchStations();
      final favoriteIds =
          await loadFavoriteStations(); // Отримуємо ID улюблених станцій

      final updatedStations = stations.map((station) {
        return station.copyWith(favorite: favoriteIds.contains(station.id));
      }).toList();

      updatedStations
          .sort((a, b) => (b.favorite ? 1 : 0).compareTo(a.favorite ? 1 : 0));

      emit(ChargeStationsLoaded(updatedStations));
    } catch (e) {
      emit(ChargeStationsError("Failed to load stations"));
    }
  }

  void _onToggleFavoriteEvent(
    ToggleFavoriteEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    final state = this.state;
    if (state is ChargeStationsLoaded) {
      final updatedStations = state.stations.map((station) {
        if (station.id == event.stationId) {
          return station.copyWith(favorite: !station.favorite);
        }
        return station;
      }).toList();

      await toggleFavoriteStation(event.stationId);

      emit(ChargeStationsLoaded(updatedStations));
    }
  }

  Future<void> toggleFavoriteStation(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_stations') ?? [];

    if (favoriteIds.contains(stationId)) {
      favoriteIds.remove(stationId);
    } else {
      favoriteIds.add(stationId);
    }

    await prefs.setStringList('favorite_stations', favoriteIds);
  }

  Future<List<String>> loadFavoriteStations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorite_stations') ?? [];
  }
}
