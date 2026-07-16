import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/usecases/check_login_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_with_google_use_case.dart';

part 'login_state.dart';

class LoginStateCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase;
  LoginWithGoogleUseCase loginWithGoogleUseCase;
  CheckLoginUseCase checkLoginUseCase;

  LoginStateCubit({
    required this.loginUseCase,
    required this.loginWithGoogleUseCase,
    required this.checkLoginUseCase,
  }) : super(LoginInitialState());

  Future<void> isLoggedIn() async {
    final result = await checkLoginUseCase.call();
    result.fold(
      (error) => emit(LoginFailureState(error.errorMsg)),
      (result) => emit(AlreadyLoggedInState(result)),
    );
  }

  Future<void> login(UserEntity user) async {
    emit(LoginLoadingState());
    final result = await loginUseCase.call(user);
    result.fold(
      (error) => emit(LoginFailureState(error.errorMsg)),
      (result) => emit(LoginSuccessState(result)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoadingState());
    final result = await loginWithGoogleUseCase.call();
    result.fold(
      (error) => emit(LoginFailureState(error.errorMsg)),
      (result) => emit(LoginSuccessState(result)),
    );
  }

  void onInput(String val) {
    emit(CheckInputState());
  }
}
