
import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class SendResetPasswordUseCase extends UseCase<void,String> {
  AuthRepo authRepo;

  SendResetPasswordUseCase(this.authRepo);

  @override
  Future<Either<Failure, void>> call([String? email]) async {
    return await authRepo.sendResetPassword(email: email!);
  }
}