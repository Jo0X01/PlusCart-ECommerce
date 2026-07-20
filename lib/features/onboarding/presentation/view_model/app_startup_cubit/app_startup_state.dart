part of 'app_startup_cubit.dart';

@immutable
sealed class AppStartupState {}

class AppStartupFailureState extends AppStartupState {
  final String msg;
  AppStartupFailureState(this.msg);
}

class AppStartupGoToSplashState extends AppStartupState {}

class AppStartupGoToOnboardingState extends AppStartupState {}

class AppStartupGoToLoginState extends AppStartupState {}

class AppStartupGoToHomeState extends AppStartupState {}
