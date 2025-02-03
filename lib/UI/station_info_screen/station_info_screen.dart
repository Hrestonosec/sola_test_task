import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'widgets/favorite_icon.dart';
import 'widgets/station_details.dart';

@RoutePage()
class StationInfoScreen extends StatelessWidget {
  final String stationId;

  // Constructor for passing the station ID to this screen
  const StationInfoScreen({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    // Dispatches event to fetch station info based on stationId
    context.read<StationInfoBloc>().add(GetStationInfo(stationId));

    return Scaffold(
      appBar: AppBar(
        title: Text("Station Info"),
        actions: [
          // Adds FavoriteIcon to app bar for toggling favorites
          FavoriteIcon(stationId: stationId),
        ],
      ),
      body: BlocBuilder<StationInfoBloc, StationInfoState>(
        // Builds UI based on the current state
        builder: (context, state) {
          if (state is StationInfoInitial) {
            // Shows a loading indicator when data is being fetched
            return Center(child: CircularProgressIndicator());
          }

          if (state is StationInfoLoaded) {
            // Displays station details when data is loaded successfully
            return StationDetails(station: state.station);
          }

          if (state is StationInfoError) {
            // Displays an error message if there was an issue fetching the data
            return Center(child: Text(state.message));
          }

          return Container(); // Default empty container if no valid state
        },
      ),
    );
  }
}
