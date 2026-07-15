
import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> login({required UserEntity user}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> register({required UserEntity user}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithGoogle() {
    // TODO: implement registerWithGoogle
    throw UnimplementedError();
  }

}