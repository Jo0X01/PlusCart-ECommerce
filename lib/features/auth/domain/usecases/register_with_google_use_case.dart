
import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class RegisterWithGoogleUseCase extends UseCase<UserEntity,NoParam> {
  AuthRepo authRepo;

  RegisterWithGoogleUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call([NoParam? noParam]) async {
    return await authRepo.loginWithGoogle();
  }
}