import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'UI/router/app_router.dart';
import 'models/charging_station.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChargingStationAdapter());
  await Hive.openBox<ChargingStation>('session_stations');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
