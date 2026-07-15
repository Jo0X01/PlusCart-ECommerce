
import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase extends UseCase<UserEntity,NoParam> {
  
  AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call([NoParam? param]) async {
    return left(ServerFailure("test"));
  }
}