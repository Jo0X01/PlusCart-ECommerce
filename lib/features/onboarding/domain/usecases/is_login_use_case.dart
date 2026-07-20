

import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/onboarding/domain/repos/startup_repo.dart';

class IsLoginUseCase extends UseCase<bool,NoParam> {
  StartupRepo startupRepo;
  IsLoginUseCase({required this.startupRepo});

  @override
  Future<Either<Failure, bool>> call([NoParam? param]) async {
    return await startupRepo.isLoggedIn();
  }
}