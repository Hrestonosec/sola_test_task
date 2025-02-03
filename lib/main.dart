import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'UI/home_screen/bloc/bloc.dart';
import 'UI/router/app_router.dart';
import 'UI/station_info_screen/bloc/bloc.dart';
import 'models/charging_station.dart';
import 'services/charge_stations_service.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures that Flutter binding is initialized

  // Initialize Hive and register ChargingStation adapter
  await Hive.initFlutter();
  Hive.registerAdapter(ChargingStationAdapter());
  await Hive.openBox<ChargingStation>(
      'session_stations'); // Open box for session data

  runApp(MyApp()); // Running the app
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter(); // Router for the app

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Provides multiple BLoCs for the app
      providers: [
        // HomeScreenBloc with initial event to fetch stations
        BlocProvider(
          create: (context) => HomeScreenBloc(ChargeStationsService())
            ..add(FetchStationsEvent()),
        ),
        BlocProvider(
            create: (context) =>
                StationInfoBloc()) // StationInfoBloc for the station info screen
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(), // Configuring app router
      ),
    );
  }
}
