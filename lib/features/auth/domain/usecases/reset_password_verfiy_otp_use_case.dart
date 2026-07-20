import 'package:dartz/dartz.dart';
import 'package:plus_cart/core/errors/failure.dart';
import 'package:plus_cart/core/usecase/usecase.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';

class OtpAttrs {
  String email;
  String code;
  OtpAttrs({required this.email, required this.code});
}

class ResetPasswordVerfiyOtpUseCase extends UseCase<void, OtpAttrs> {
  AuthRepo authRepo;

  ResetPasswordVerfiyOtpUseCase(this.authRepo);

  @override
  Future<Either<Failure, void>> call([OtpAttrs? code]) async {
    return await authRepo.verfiyOtpCode(email: code!.email, code: code.code);
  }
}
