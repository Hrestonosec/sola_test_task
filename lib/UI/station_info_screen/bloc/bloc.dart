import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/charging_station.dart';

part 'states.dart';
part 'events.dart';

class StationInfoBloc extends Bloc<StationInfoEvent, StationInfoState> {
  StationInfoBloc() : super(StationInfoInitial()) {
    on<GetStationLocation>(_onOpenMap);
  }

  Future<void> _onOpenMap(
      GetStationLocation event, Emitter<StationInfoState> emit) async {
    emit(OpenStationLocation());
  }
}
