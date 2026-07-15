part of 'login_state_cubit.dart';

@immutable
sealed class LoginStateState {}

final class LoginInitialState extends LoginStateState {}

final class LoginLoadingState extends LoginStateState {}

final class AlreadyLoggedInState extends LoginStateState {
  final UserEntity user;
  AlreadyLoggedInState(this.user);
}

final class NotLoggedInState extends LoginStateState {}

final class LoginSuccessState extends LoginStateState {
  final UserEntity user;
  LoginSuccessState(this.user);
}

final class LoginFailureState extends LoginStateState {
  final String msg;
  LoginFailureState(this.msg);
}
