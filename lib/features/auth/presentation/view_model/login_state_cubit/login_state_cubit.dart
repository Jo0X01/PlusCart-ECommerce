import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/usecases/check_login_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_use_case.dart';

part 'login_state_state.dart';

class LoginStateCubit extends Cubit<LoginStateState> {
  LoginUseCase loginUseCase;
  CheckLoginUseCase checkLoginUseCase;

  LoginStateCubit({required this.loginUseCase, required this.checkLoginUseCase})
    : super(LoginInitialState());

  Future<void> isLoggedIn() async {
    final result = await checkLoginUseCase.call();
    result.fold(
      (error) => LoginFailureState(error.errorMsg),
      (result) => AlreadyLoggedInState(result),
    );
  }

  Future<void> login(UserEntity user) async {
    LoginLoadingState();
    final result = await loginUseCase.call(user);
    result.fold(
      (error) => LoginFailureState(error.errorMsg),
      (result) => LoginSuccessState(result),
    );
  }
}
