import 'package:dio/dio.dart';
import 'dart:convert';

import '../models/charging_station.dart';

class ChargeStationsService {
  Future<List<ChargingStation>> fetchStations() async {
    final url =
        'https://gist.githubusercontent.com/Hrestonosec/a71b59c0ac5571e9b693cf6c96aa938b/raw/717a2d8bf39f5841cd5dd8fb3ccef9b16a4bdfee/charging_stations.json';
    try {
      final response = await Dio().get(url);
      final List<dynamic> jsonList = jsonDecode(response.data);
      return jsonList.map((json) => ChargingStation.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
