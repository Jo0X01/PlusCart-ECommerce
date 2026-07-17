
import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class RegisterUseCase extends UseCase<UserEntity,UserEntity> {
  AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call([UserEntity? user]) async {
    return await authRepo.register(user: user!);
  }
}