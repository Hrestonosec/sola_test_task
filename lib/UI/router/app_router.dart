import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

// Routs list
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(
          page: StationInfoRoute.page,
        ),
      ];
}

class $AppRouter {}
