import 'package:go_router/go_router.dart';
import 'package:plus_cart/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:plus_cart/features/onboarding/presentation/screens/splash_screen.dart';

abstract class AppRoutes {
  static const splashScreen = "/splash";
  static const onBoardingScreen = "/onboarding";
}

final appRoutes = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onBoardingScreen,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);
