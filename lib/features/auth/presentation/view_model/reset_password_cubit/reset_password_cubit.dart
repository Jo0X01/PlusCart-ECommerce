import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/auth/domain/usecases/reset_password_verfiy_otp_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/send_reset_password_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/update_password_use_case.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  SendResetPasswordUseCase sendResetPasswordUseCase;
  ResetPasswordVerfiyOtpUseCase verfiyOtpUseCase;
  UpdatePasswordUseCase updatePasswordUseCase;

  ResetPasswordCubit({
    required this.sendResetPasswordUseCase,
    required this.verfiyOtpUseCase,
    required this.updatePasswordUseCase,
  }) : super(ResetPasswordEnterEmailState());

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  ResetPasswordStep currentStep = ResetPasswordStep.email;

  Future<void> sendConfirmCode({required String email}) async {
    emit(ResetPasswordLoadingState());
    final result = await sendResetPasswordUseCase.call(email);
    result.fold(
      (failure) => emit(ResetPasswordFailureState(failure.errorMsg)),
      (_) {
        currentStep = ResetPasswordStep.otp;
        emit(ResetPasswordEnterOtpState(email));
      },
    );
  }

  Future<void> verfiyOtpCode({
    required String email,
    required String code,
  }) async {
    emit(ResetPasswordLoadingState());
    final result = await verfiyOtpUseCase.call(
      OtpAttrs(email: email, code: code),
    );
    result.fold(
      (failure) => emit(ResetPasswordFailureState(failure.errorMsg)),
      (_) {
        currentStep = ResetPasswordStep.password;
        emit(ResetPasswordEnterPasswordState());
      },
    );
  }

  Future<void> updatePassword({
    required String password,
    required String cPassword,
  }) async {
    if (password != cPassword) {
      emit(ResetPasswordFailureState("Passwords do not match"));
      return;
    }
    emit(ResetPasswordLoadingState());
    final result = await updatePasswordUseCase.call(password);
    result.fold(
      (failure) => emit(ResetPasswordFailureState(failure.errorMsg)),
      (_) {
        emit(ResetPasswordSuccessState());
      },
    );
  }

  void onValidateEmail(bool valid) {
    _isEmailValid = valid;
    emit(ResetPasswordValidInputState(_isEmailValid));
  }

  void onValidatePassword(bool valid) {
    _isPasswordValid = valid;
    emit(
      ResetPasswordValidInputState(_isPasswordValid && _isConfirmPasswordValid),
    );
  }

  void onValidateConfirmPassword(bool valid) {
    _isConfirmPasswordValid = valid;
    emit(
      ResetPasswordValidInputState(_isPasswordValid && _isConfirmPasswordValid),
    );
  }

  void onOtpCompelete(bool validOtp) {
    emit(ResetPasswordValidInputState(validOtp));
  }
}
