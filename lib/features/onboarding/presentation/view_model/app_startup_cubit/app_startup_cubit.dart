import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/get_current_user_use_case.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/is_login_use_case.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/is_logout_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_startup_state.dart';

class AppStartupCubit extends Cubit<AppStartupState> {
  IsLoginUseCase isLoginUseCase;
  IsLogoutUseCase isLogoutUseCase;
  GetCurrentUserUseCase getCurrentUserUseCase;

  AppStartupCubit({
    required this.isLoginUseCase,
    required this.isLogoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AppStartupGoToOnboardingState());

  Future<void> isLoggedIn() async {
    final result = await isLoginUseCase.call();
    result.fold((failure) => emit(AppStartupFailureState(failure.errorMsg)), (
      value,
    ) {
      if (value) {
        emit(AppStartupGoToLoginState());
      }
    });
  }

  Future<void> isLoggedOut() async {
    final result = await isLogoutUseCase.call();
    result.fold((failure) => emit(AppStartupFailureState(failure.errorMsg)), (
      value,
    ) {
      if (value) {
        emit(AppStartupGoToOnboardingState());
      }
    });
  }

  Future<void> getCurrentUser() async {
    final result = await getCurrentUserUseCase.call();
    result.fold(
      (failure) => emit(AppStartupFailureState(failure.errorMsg)),
      (user) => emit(
        user == null
            ? AppStartupGoToLoginState()
            : AppStartupGoToHomeState(user),
      ),
    );
  }
}
