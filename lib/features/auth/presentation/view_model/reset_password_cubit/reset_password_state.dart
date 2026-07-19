part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}
final class ResetPasswordFailureState extends ResetPasswordState {
  final String msg;
  ResetPasswordFailureState(this.msg);
}
