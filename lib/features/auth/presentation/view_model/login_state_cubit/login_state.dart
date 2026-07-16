part of 'login_state_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}
final class CheckInputState extends LoginState {}

final class AlreadyLoggedInState extends LoginState {
  final UserEntity user;
  AlreadyLoggedInState(this.user);
}

final class NotLoggedInState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final UserEntity user;
  LoginSuccessState(this.user);
}

final class LoginFailureState extends LoginState {
  final String msg;
  LoginFailureState(this.msg);
}
