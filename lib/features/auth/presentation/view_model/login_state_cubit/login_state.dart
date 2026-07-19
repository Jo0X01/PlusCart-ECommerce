part of 'login_state_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}
final class CheckInputState extends LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  CheckInputState({required this.isEmailValid, required this.isPasswordValid});
}

final class LoginSuccessState extends LoginState {
  final UserEntity user;
  LoginSuccessState(this.user);
}

final class LoginFailureState extends LoginState {
  final String msg;
  LoginFailureState(this.msg);
}
