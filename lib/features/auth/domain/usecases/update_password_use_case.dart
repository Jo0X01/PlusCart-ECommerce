import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class UpdatePasswordUseCase extends UseCase<void, String> {
  AuthRepo authRepo;

  UpdatePasswordUseCase(this.authRepo);

  @override
  Future<Either<Failure, void>> call([String? password]) async {
    return await authRepo.updatePassword(password: password!);
  }
}
