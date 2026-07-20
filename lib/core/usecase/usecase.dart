import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';

abstract class UseCase<T, Param> {
  Future<Either<Failure, T>> call([Param? param]);
}

class NoParam {}
