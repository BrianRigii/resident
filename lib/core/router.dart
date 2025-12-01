import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resident/features/auth/domain/auth_service.dart';
import 'package:resident/features/auth/presentation/auth_screen.dart';
import 'package:resident/home_screen.dart';
import 'package:resident/splash_screen.dart';

GoRouter router = GoRouter(
  initialLocation: SplashScreen.path,
  routes: [
    GoRoute(
      path: SplashScreen.path,
      builder: (context, state) => const SplashScreen(),
      redirect: (context, state) {
        return context.read<AuthService>().currentUser == null
            ? AuthScreen.path
            : HomeScreen.path;
      },
    ),
    GoRoute(
      path: AuthScreen.path,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: HomeScreen.path,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
