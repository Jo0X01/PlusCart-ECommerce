import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StartupRepo {
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, bool>> isLoggedOut();
  Future<Either<Failure, User?>> getCurrentUser();
}
