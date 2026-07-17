import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/usecases/register_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/register_with_google_use_case.dart';

part 'register_state.dart';

class RegisterStateCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  final RegisterWithGoogleUseCase registerWithGoogleUseCase;

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isFullNameValid = false;

  RegisterStateCubit({
    required this.registerUseCase,
    required this.registerWithGoogleUseCase,
  }) : super(RegisterInitialState());

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    final result = await registerUseCase.call(
      UserEntity(fullName: fullName, email: email, password: password),
    );
    result.fold(
      (error) => emit(RegisterFailureState(error.errorMsg)),
      (result) => emit(RegisterSuccessState(result)),
    );
  }

  Future<void> registerWithGoogle() async {
    emit(RegisterLoadingState());
    final result = await registerWithGoogleUseCase.call();
    result.fold(
      (error) => emit(RegisterFailureState(error.errorMsg)),
      (result) => emit(RegisterSuccessState(result)),
    );
  }

  void onEmailInput(bool valid) {
    isEmailValid = valid;
    _emitInputState();
  }

  void onPasswordInput(bool valid) {
    isPasswordValid = valid;
    _emitInputState();
  }

  void onFullNameInput(bool valid) {
    isFullNameValid = valid;
    _emitInputState();
  }

  void _emitInputState() {
    emit(
      RegisterCheckInputState(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isFullNameValid: isFullNameValid,
      ),
    );
  }
}
