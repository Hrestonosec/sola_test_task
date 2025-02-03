import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class FavoriteIcon extends StatelessWidget {
  final String stationId;
  const FavoriteIcon({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationInfoBloc, StationInfoState>(
      builder: (context, state) {
        bool isFavorite = false;

        // Check if the state is loaded and get the favorite status
        if (state is StationInfoLoaded) {
          isFavorite = state.station.favorite;
        }

        return IconButton(
          icon: Icon(isFavorite
              ? Icons.star
              : Icons.star_border), // Display star based on favorite status
          color: isFavorite
              ? Colors.amber
              : Colors.grey, // Set color based on favorite status
          onPressed: () {
            // Dispatch event to toggle the favorite status
            context.read<StationInfoBloc>().add(ToggleFavoriteEvent(stationId));
          },
        );
      },
    );
  }
}
