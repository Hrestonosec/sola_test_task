import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/charging_station.dart';
import '../../../services/charge_stations_service.dart';

part 'states.dart';
part 'events.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ChargeStationsService _service;

  // Constructor initializes the BLoC with the service and sets up event handlers
  HomeScreenBloc(this._service) : super(ChargeStationsLoading()) {
    on<FetchStationsEvent>(
        _onFetchStationsEvent); // Fetch stations when event occurs
    on<ToggleFavoriteEvent>(
        _onToggleFavoriteEvent); // Handle toggling favorite status
    on<CheckStationStatusEvent>(
        _onCheckStationStatusEvent); // Check station status
  }

  // Fetching station data from the service and updating the state
  Future<void> _onFetchStationsEvent(
    FetchStationsEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(ChargeStationsLoading()); // Emit loading state while fetching data
    try {
      final stations =
          await _service.fetchStations(); // Fetch stations from API
      final favoriteIds =
          await loadFavoriteStations(); // Get the list of favorite station IDs

      // Map the stations to add the favorite status based on the saved list
      final updatedStations = stations.map((station) {
        return station.copyWith(favorite: favoriteIds.contains(station.id));
      }).toList();

      // Sort stations to have favorites first
      updatedStations
          .sort((a, b) => (b.favorite ? 1 : 0).compareTo(a.favorite ? 1 : 0));

      // Emit the updated stations list
      emit(ChargeStationsLoaded(updatedStations));
    } catch (e) {
      emit(ChargeStationsError(
          "Failed to load stations")); // Emit error state if fetching fails
    }
  }

  // Toggle the favorite status for a station
  void _onToggleFavoriteEvent(
    ToggleFavoriteEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    final state = this.state;
    if (state is ChargeStationsLoaded) {
      // Map through stations and update the favorite status for the specific station
      final updatedStations = state.stations.map((station) {
        if (station.id == event.stationId) {
          return station.copyWith(
              favorite: !station.favorite); // Toggle favorite status
        }
        return station;
      }).toList();

      await toggleFavoriteStation(
          event.stationId); // Update the saved favorite status

      // Emit the updated list of stations
      emit(ChargeStationsLoaded(updatedStations));
    }
  }

  // Check if a station's favorite status needs to be updated when coming back to the screen
  void _onCheckStationStatusEvent(
    CheckStationStatusEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    final favoriteIds =
        await loadFavoriteStations(); // Load the current favorite stations

    // Check if the given ID is in the list of favorites
    bool isFavorite = favoriteIds.contains(event.stationId);

    final state = this.state;
    if (state is ChargeStationsLoaded) {
      // Update the station's favorite status if the ID matches
      final updatedStations = state.stations.map((station) {
        if (station.id == event.stationId) {
          return station.copyWith(
              favorite: isFavorite); // Change the favorite status
        }
        return station;
      }).toList();

      // Emit the updated list of stations
      emit(ChargeStationsLoaded(updatedStations));
    }
  }

  // Toggle the favorite status in SharedPreferences
  Future<void> toggleFavoriteStation(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_stations') ?? [];

    // Add or remove the station ID from the favorite list
    if (favoriteIds.contains(stationId)) {
      favoriteIds.remove(stationId);
    } else {
      favoriteIds.add(stationId);
    }
    await prefs.setStringList(
        'favorite_stations', favoriteIds); // Save the updated list
  }

  // Load the list of favorite stations from SharedPreferences
  Future<List<String>> loadFavoriteStations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorite_stations') ??
        []; // Return the list or an empty list if not found
  }
}
