import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/charge_stations_service.dart';
import 'bloc/bloc.dart';
import 'widgets/charge_station_tile.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeScreenBloc(ChargeStationsService())..add(FetchStationsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Charging Stations'),
        ),
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            if (state is ChargeStationsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChargeStationsLoaded) {
              return ListView.builder(
                itemCount: state.stations.length,
                itemBuilder: (context, index) {
                  final station = state.stations[index];
                  return ChargingStationTile(station: station);
                },
              );
            } else if (state is ChargeStationsError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
