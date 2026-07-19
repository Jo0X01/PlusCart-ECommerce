import 'package:get_it/get_it.dart';
import 'package:plus_cart/core/services/google_sign_in_service.dart';
import 'package:plus_cart/core/services/supabase_service.dart';
import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source.dart';
import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source_imp.dart';
import 'package:plus_cart/features/auth/data/repos/auth_repo_imp.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_with_google_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/register_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/register_with_google_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/reset_password_verfiy_otp_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/send_reset_password_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:plus_cart/features/auth/presentation/view_model/login_state_cubit/login_state_cubit.dart';
import 'package:plus_cart/features/auth/presentation/view_model/register_state_cubit/register_state_cubit.dart';
import 'package:plus_cart/features/auth/presentation/view_model/reset_password_cubit/reset_password_cubit.dart';

void initAuthDependencies(GetIt getIt) {
  getIt.registerLazySingleton<RemoteAuthDataSource>(
    () => RemoteAuthDataSourceImp(
      supabaseService: getIt.get<SupabaseService>(),
      googleSignInService: getIt.get<GoogleSignInService>(),
    ),
  );
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImp(remoteAuthDataSource: getIt.get<RemoteAuthDataSource>()),);

  getIt.registerLazySingleton(() => LoginUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => LoginWithGoogleUseCase(getIt.get<AuthRepo>()),);
  getIt.registerLazySingleton(() => RegisterWithGoogleUseCase(getIt.get<AuthRepo>()),);
  getIt.registerLazySingleton(() => RegisterUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => SendResetPasswordUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => ResetPasswordVerfiyOtpUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => UpdatePasswordUseCase(getIt.get<AuthRepo>()));

  getIt.registerFactory(
    () => LoginStateCubit(
      loginWithGoogleUseCase: getIt.get<LoginWithGoogleUseCase>(),
      loginUseCase: getIt.get<LoginUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => RegisterStateCubit(
      registerUseCase: getIt.get<RegisterUseCase>(),
      registerWithGoogleUseCase: getIt.get<RegisterWithGoogleUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => ResetPasswordCubit(
      sendResetPasswordUseCase: getIt.get<SendResetPasswordUseCase>(),
      verfiyOtpUseCase: getIt.get<ResetPasswordVerfiyOtpUseCase>(),
      updatePasswordUseCase: getIt.get<UpdatePasswordUseCase>()
    ),
  );
}
