import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/app/app_init.dart';
import 'package:plus_cart/features/auth/presentation/view/screens/login_screen.dart';
import 'package:plus_cart/features/auth/presentation/view/screens/register_screen.dart';
import 'package:plus_cart/features/auth/presentation/view_model/login_state_cubit/login_state_cubit.dart';
import 'package:plus_cart/features/auth/presentation/view_model/register_state_cubit/register_state_cubit.dart';
import 'package:plus_cart/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:plus_cart/features/onboarding/presentation/screens/splash_screen.dart';

abstract class AppRoutes {
  static const splashScreen = "/splash";
  static const onBoardingScreen = "/onboarding";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const frogetPasswordScreen = "/forget-password";
  static const homeScreen = "/home-screen";
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
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => BlocProvider<LoginStateCubit>(
        create: (context) => getIt.get<LoginStateCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.registerScreen,
      builder: (context, state) => BlocProvider<RegisterStateCubit>(
        create: (context) => getIt.get<RegisterStateCubit>(),
        child: const RegisterScreen(),
      ),
    ),
  ],
);
