

import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/onboarding/domain/repos/startup_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetCurrentUserUseCase extends UseCase<User?,NoParam> {
  StartupRepo startupRepo;
  GetCurrentUserUseCase({required this.startupRepo});

  @override
  Future<Either<Failure, User?>> call([NoParam? param]) async {
    return await startupRepo.getCurrentUser();
  }
}