import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sola_test_task/UI/router/app_router.gr.dart';

import '../../../models/charging_station.dart';
import '../bloc/bloc.dart';

class ChargingStationTile extends StatelessWidget {
  final ChargingStation station;

  const ChargingStationTile({required this.station});

  void _onStationTap(BuildContext context, ChargingStation station) async {
    var box = Hive.box<ChargingStation>('session_stations');

    if (!box.containsKey(station.id)) {
      await box.put(station.id, station);
    }

    context.router.push(StationInfoRoute(stationId: station.id));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(station.name),
      subtitle: Text('Price: \$${station.price} - Rating: ${station.rating}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(station.favorite ? Icons.star : Icons.star_border),
            color: station.favorite ? Colors.amber : null,
            onPressed: () {
              context
                  .read<HomeScreenBloc>()
                  .add(ToggleFavoriteEvent(station.id));
            },
          ),
          Icon(station.isAvailable ? Icons.check_circle : Icons.remove_circle),
        ],
      ),
      onTap: () => _onStationTap(context, station),
    );
  }
}
