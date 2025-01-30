// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:sola_test_task/UI/home_screen/home_screen.dart' as _i1;
import 'package:sola_test_task/UI/station_info_screen/station_info_screen.dart'
    as _i2;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.StationInfoScreen]
class StationInfoRoute extends _i3.PageRouteInfo<StationInfoRouteArgs> {
  StationInfoRoute({
    _i4.Key? key,
    required String stationId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          StationInfoRoute.name,
          args: StationInfoRouteArgs(
            key: key,
            stationId: stationId,
          ),
          initialChildren: children,
        );

  static const String name = 'StationInfoRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StationInfoRouteArgs>();
      return _i2.StationInfoScreen(
        key: args.key,
        stationId: args.stationId,
      );
    },
  );
}

class StationInfoRouteArgs {
  const StationInfoRouteArgs({
    this.key,
    required this.stationId,
  });

  final _i4.Key? key;

  final String stationId;

  @override
  String toString() {
    return 'StationInfoRouteArgs{key: $key, stationId: $stationId}';
  }
}
