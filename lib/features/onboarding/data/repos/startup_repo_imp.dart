import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/features/onboarding/data/data_source/remote/remote_app_startup_data_source.dart';
import 'package:plus_cart/features/onboarding/domain/repos/startup_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartupRepoImp extends StartupRepo {
  RemoteAppStartupDataSource remoteAppStartupDataSource;
  StartupRepoImp({required this.remoteAppStartupDataSource});

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final result = await remoteAppStartupDataSource.getCurrentUser();
      return right(result);
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final result = await remoteAppStartupDataSource.isLoggedIn();
      return right(result);
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedOut() async {
    try {
      final result = await remoteAppStartupDataSource.isLoggedOut();
      return right(result);
    } catch (e) {
      if (SupabaseFailure.isException(e)) {
        return left(SupabaseFailure.fromException(e));
      }
      return left(SupabaseFailure(e.toString()));
    }
  }
}
