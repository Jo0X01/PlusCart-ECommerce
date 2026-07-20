import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_with_google_use_case.dart';

part 'login_state.dart';

class LoginStateCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  bool isEmailValid = false;
  bool isPasswordValid = false;

  LoginStateCubit({
    required this.loginUseCase,
    required this.loginWithGoogleUseCase,
  }) : super(LoginInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final result = await loginUseCase.call(
      UserEntity(email: email, password: password),
    );
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

  void onEmailInput(bool valid) {
    isEmailValid = valid;
    emit(
      CheckInputState(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
      ),
    );
  }

  void onPasswordInput(bool valid) {
    isPasswordValid = valid;
    emit(
      CheckInputState(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
      ),
    );
  }
}
