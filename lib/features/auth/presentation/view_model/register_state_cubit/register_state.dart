part of 'register_state_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterCheckInputState extends RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFullNameValid;
  RegisterCheckInputState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isFullNameValid,
  });

  bool get isValid => isEmailValid && isPasswordValid && isFullNameValid; 
}

final class RegisterSuccessState extends RegisterState {
  final UserEntity user;
  RegisterSuccessState(this.user);
}

final class RegisterFailureState extends RegisterState {
  final String msg;
  RegisterFailureState(this.msg);
}
