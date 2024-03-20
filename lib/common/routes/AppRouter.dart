import 'package:go_router/go_router.dart';
import 'package:movie_booking/core/constant/string.dart' as router;
import 'package:movie_booking/features/urban/presentation/views/error/error_route_screen.dart';
import 'package:movie_booking/features/urban/presentation/views/error/not_found_screen.dart';
import 'package:movie_booking/features/urban/presentation/views/init_view.dart';
import 'package:movie_booking/features/urban/presentation/views/skeleton/skeleton_screen.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter routes = GoRouter(
    initialLocation: router.initRoute,
    errorBuilder: (context, state) => ErrorRouteScreen(exception: state.error),
    routes: <GoRoute>[
      GoRoute(
        path: router.initRoute,
        builder: (context, state) => const InitScreen(),
      ),
      GoRoute(
        path: router.skeletonRoute,
        builder: (context, state) => const SkeletonScreen(),
      ),
      GoRoute(
        path: router.notFoundRoute,
        builder: (context, state) => NotFoundScreen(exception: state.error),
      ),
    ],
  );
}
