
import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure,UserEntity>> getCurrentUser();

  Future<Either<Failure,UserEntity>> login({required UserEntity user});
  Future<Either<Failure,UserEntity>> loginWithGoogle();

  Future<Either<Failure,UserEntity>> register({required UserEntity user});
  Future<Either<Failure,UserEntity>> registerWithGoogle();

}