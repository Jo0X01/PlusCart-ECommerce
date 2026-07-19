import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/features/auth/domain/usecases/send_reset_password_use_case.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  SendResetPasswordUseCase sendResetPasswordUseCase;
  
  ResetPasswordCubit({
    required this.sendResetPasswordUseCase
  }) : super(ResetPasswordInitial());
}
