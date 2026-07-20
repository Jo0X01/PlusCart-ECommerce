import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/app/app_init.dart';
import 'package:plus_cart/features/auth/presentation/view/screens/login_screen.dart';
import 'package:plus_cart/features/auth/presentation/view/screens/register_screen.dart';
import 'package:plus_cart/features/auth/presentation/view/screens/reset_password_screen.dart';
import 'package:plus_cart/features/auth/presentation/view_model/login_state_cubit/login_state_cubit.dart';
import 'package:plus_cart/features/auth/presentation/view_model/register_state_cubit/register_state_cubit.dart';
import 'package:plus_cart/features/auth/presentation/view_model/reset_password_cubit/reset_password_cubit.dart';
import 'package:plus_cart/features/home/presentation/view/screens/home_screen.dart';
import 'package:plus_cart/features/onboarding/presentation/view/screens/startup_screen.dart';

abstract class AppRoutes {
  static const startUpScreen = "/startup";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const frogetPasswordScreen = "/forget-password";
  static const homeScreen = "/home-screen";
}

final appRoutes = GoRouter(
  initialLocation: AppRoutes.homeScreen,//.startUpScreen,
  routes: [
    GoRoute(
      path: AppRoutes.startUpScreen,
      builder: (context, state) => const StartupScreen(),
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
    GoRoute(
      path: AppRoutes.frogetPasswordScreen,
      builder: (context, state) => BlocProvider<ResetPasswordCubit>(
        create: (context) => getIt.get<ResetPasswordCubit>(),
        child: const ResetPasswordScreen(),
      ),
    ),
  ],
);
