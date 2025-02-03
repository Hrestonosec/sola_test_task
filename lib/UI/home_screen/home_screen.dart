import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'widgets/charge_station_tile.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charging Stations'),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        // Listening for state changes
        builder: (context, state) {
          if (state is ChargeStationsLoading) {
            return Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (state is ChargeStationsLoaded) {
            return ListView.builder(
              itemCount: state.stations.length, // List item count from state
              itemBuilder: (context, index) {
                final station =
                    state.stations[index]; // Get the station at current index
                return ChargingStationTile(
                    station: station); // Display each station tile
              },
            );
          } else if (state is ChargeStationsError) {
            return Center(child: Text(state.message)); // Show error message
          }
          return Container(); // Empty state, shouldn't be reached
        },
      ),
    );
  }
}
