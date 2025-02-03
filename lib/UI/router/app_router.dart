import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

// Routes list
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: HomeRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders
              .slideRightWithFade, // Animation for transition
          durationInMilliseconds: 500,
        ),
        CustomRoute(
          page: StationInfoRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 500,
        ),
      ];
}

class $AppRouter {}
