import 'package:flutter/material.dart';
import 'package:sola_test_task/models/charging_station.dart';

class StationDetails extends StatelessWidget {
  final ChargingStation station;
  const StationDetails({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Allows scrolling if content is too long
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address section
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.blue),
            title:
                Text("Address:", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(station.address, style: TextStyle(fontSize: 16)),
          ),
          Divider(),

          // Coordinates section with tap gesture for potential interaction
          ListTile(
            leading: Icon(Icons.map, color: Colors.green),
            title: Text("Coordinates:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: GestureDetector(
              onTap: () {}, // Add functionality if needed
              child: Text("${station.latitude}, ${station.longitude}",
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
            ),
          ),
          Divider(),

          // Power and operator details
          ListTile(
            leading: Icon(Icons.electrical_services, color: Colors.orange),
            title: Text("Power & Operator:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${station.power} kW - ${station.operator}",
                style: TextStyle(fontSize: 16)),
          ),
          Divider(),

          // Price and rating information
          ListTile(
            leading: Icon(Icons.attach_money, color: Colors.green),
            title: Text("Price & Rating:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
                "\$${station.price} per kW  •  ${station.rating}/5 ★",
                style: TextStyle(fontSize: 16)),
          ),
          Divider(),

          // Connectors list with each connector as a bullet point
          ListTile(
            leading: Icon(Icons.power, color: Colors.purple),
            title: Text("Connectors:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: station.connectors
                  .map((connector) => Text("• $connector",
                      style: TextStyle(fontSize: 16))) // Connector list
                  .toList(),
            ),
          ),
          Divider(),

          // Availability status card with visual indicator
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: station.isAvailable ? Colors.green[100] : Colors.red[100],
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Availability icon and text
                  Icon(
                    station.isAvailable ? Icons.check_circle : Icons.cancel,
                    color: station.isAvailable ? Colors.green : Colors.red,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    station.isAvailable ? "Available" : "Not Available",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: station.isAvailable
                          ? Colors.green[800]
                          : Colors.red[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
