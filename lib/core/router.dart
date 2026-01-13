import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:resident/features/auth/presentation/auth_notifier.dart';
import 'package:resident/features/auth/presentation/auth_screen.dart';
import 'package:resident/features/profile/presentation/profile_screen.dart';

import 'package:resident/features/properties/presentation/properties_screen.dart';
import 'package:resident/features/units/presentation/units_screen.dart';
import 'package:resident/home_screen.dart';
import 'package:resident/splash_screen.dart';

GoRouter router = GoRouter(
  initialLocation: SplashScreen.path,
  routes: [
    GoRoute(
      path: SplashScreen.path,
      builder: (context, state) => const SplashScreen(),
      redirect: (context, state) {
        return context.read<AuthNotifier>().currentUser == null
            ? AuthScreen.path
            : DashboardScreen.path;
      },
    ),
    GoRoute(
      path: AuthScreen.path,
      builder: (context, state) => const AuthScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: DashboardScreen.path,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PropertiesScreen.path,
              builder: (context, state) => const PropertiesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: UnitsScreen.path,
              builder: (context, state) => const UnitsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ProfileScreen.path,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
