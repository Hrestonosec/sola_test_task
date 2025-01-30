import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/charging_station.dart';
import '../../../services/charge_stations_service.dart';

part 'states.dart';
part 'events.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ChargeStationsService _service;

  HomeScreenBloc(this._service) : super(ChargeStationsLoading()) {
    on<FetchStationsEvent>(_onFetchStationsEvent);
  }

  Future<void> _onFetchStationsEvent(
    FetchStationsEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(ChargeStationsLoading());
    try {
      final stations = await _service.fetchStations();
      emit(ChargeStationsLoaded(stations));
    } catch (e) {
      emit(ChargeStationsError("Failed to load stations"));
    }
  }
}
