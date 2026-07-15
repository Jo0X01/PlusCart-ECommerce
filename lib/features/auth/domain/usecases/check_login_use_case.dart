
import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class CheckLoginUseCase extends UseCase<UserEntity,NoParam> {
  AuthRepo authRepo;

  CheckLoginUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call([NoParam? noParam]) async {
    return await authRepo.getCurrentUser();
  }
}