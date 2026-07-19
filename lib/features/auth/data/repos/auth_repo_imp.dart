import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source.dart';
import 'package:plus_cart/features/auth/data/mappers/user_mapper.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final RemoteAuthDataSource remoteAuthDataSource;

  AuthRepoImp({required this.remoteAuthDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({required UserEntity user}) async {
    try {
      final result = await remoteAuthDataSource.login(
        email: user.email!,
        password: user.password!,
      );
      return right(userToEntityMapper(result!));
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final result = await remoteAuthDataSource.loginWithGoogle();
      return right(userToEntityMapper(result!));
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      if (!(await remoteAuthDataSource.isAlreadyAuth())) {
        return right(null);
      }
      final result = await remoteAuthDataSource.getCurrentUser();
      return right(userToEntityMapper(result!));
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required UserEntity user,
  }) async {
    try {
      final result = await remoteAuthDataSource.register(
        email: user.email!,
        fullName: user.fullName!,
        password: user.password!,
      );
      return right(userToEntityMapper(result!));
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithGoogle() async {
    try {
      final result = await remoteAuthDataSource.registerWithGoogle();
      return right(userToEntityMapper(result!));
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendResetPassword({
    required String email,
  }) async {
    try {
      final result = await remoteAuthDataSource.sendForgetPasswordToken(
        email: email,
      );
      return right(result);
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }
}
