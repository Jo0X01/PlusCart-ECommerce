part of 'reset_password_cubit.dart';

enum ResetPasswordStep { email, otp, password }

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordEnterEmailState extends ResetPasswordState {}

final class ResetPasswordEnterOtpState extends ResetPasswordState {
  final String email;
  ResetPasswordEnterOtpState(this.email);
}

final class ResetPasswordEnterPasswordState extends ResetPasswordState {}

final class ResetPasswordFailureState extends ResetPasswordState {
  final String msg;
  ResetPasswordFailureState(this.msg);
}

final class ResetPasswordSuccessState extends ResetPasswordState {}

final class ResetPasswordValidInputState extends ResetPasswordState {
  final bool valid;
  ResetPasswordValidInputState(this.valid);
}

final class ResetPasswordLoadingState extends ResetPasswordState {}
