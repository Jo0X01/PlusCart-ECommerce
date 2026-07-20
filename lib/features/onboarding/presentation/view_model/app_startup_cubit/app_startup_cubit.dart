import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/get_current_user_use_case.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/is_login_use_case.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/is_logout_use_case.dart';

part 'app_startup_state.dart';

class AppStartupCubit extends Cubit<AppStartupState> {
  final IsLoginUseCase isLoginUseCase;
  final IsLogoutUseCase isLogoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AppStartupCubit({
    required this.isLoginUseCase,
    required this.isLogoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AppStartupGoToSplashState());

  Future<void> checkStartup() async {
    final loginResult = await isLoginUseCase.call();

    loginResult.fold(
      (failure) => emit(AppStartupFailureState(failure.errorMsg)),
      (isLoggedIn) async {
        if (!isLoggedIn) {
          emit(AppStartupGoToOnboardingState());
          return;
        }
        final userResult = await getCurrentUserUseCase.call();
        userResult.fold(
          (failure) => emit(AppStartupFailureState(failure.errorMsg)),
          (user) {
            if (user != null) {
              emit(AppStartupGoToHomeState());
            } else {
              emit(AppStartupGoToLoginState());
            }
          },
        );
      },
    );
  }

  Future<void> logout() async {
    final result = await isLogoutUseCase.call();
    result.fold(
      (failure) => emit(AppStartupFailureState(failure.errorMsg)),
      (_) => emit(AppStartupGoToLoginState()),
    );
  }
}
