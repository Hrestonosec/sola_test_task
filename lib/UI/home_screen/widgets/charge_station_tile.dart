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

    // Store station if not already present
    if (!box.containsKey(station.id)) {
      await box.put(station.id, station);
    }
    // Navigate to StationInfo screen
    await context.router.push(StationInfoRoute(stationId: station.id));
    // Trigger event to update station status
    context.read<HomeScreenBloc>().add(CheckStationStatusEvent(station.id));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          station.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.green, size: 18),
                SizedBox(width: 4),
                Text('\$${station.price}/kW',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                SizedBox(width: 12),
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text('${station.rating}/5.0',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    station.isAvailable ? Colors.green[100] : Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                station.isAvailable ? "Available" : "In Use",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      station.isAvailable ? Colors.green[800] : Colors.red[800],
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(station.favorite ? Icons.star : Icons.star_border),
          color: station.favorite ? Colors.amber : Colors.grey,
          onPressed: () {
            // Trigger event to toggle favorite status
            context.read<HomeScreenBloc>().add(ToggleFavoriteEvent(station.id));
          },
        ),
        onTap: () => _onStationTap(context, station),
      ),
    );
  }
}
