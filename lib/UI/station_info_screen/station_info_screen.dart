import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sola_test_task/models/charging_station.dart';

@RoutePage()
class StationInfoScreen extends StatelessWidget {
  final String stationId;

  const StationInfoScreen({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<ChargingStation>('session_stations');
    final station = box.get(stationId);

    if (station == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Station Not Found")),
        body: Center(child: Text("Station data is missing.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(station.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address: ${station.address}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {}, // Заглушка
              child: Text(
                "Coordinates: ${station.latitude}, ${station.longitude}",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            SizedBox(height: 8),
            Text("Power: ${station.power} kW", style: TextStyle(fontSize: 16)),
            Text("Operator: ${station.operator}",
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
