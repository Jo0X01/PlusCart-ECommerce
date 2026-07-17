import 'package:plus_cart/core/services/service_alocator.dart';

import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source.dart';
import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source_imp.dart';
import 'package:plus_cart/features/auth/data/repos/auth_repo_imp.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';
import 'package:plus_cart/features/auth/domain/usecases/check_login_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/login_with_google_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/register_use_case.dart';
import 'package:plus_cart/features/auth/domain/usecases/register_with_google_use_case.dart';
import 'package:plus_cart/features/auth/presentation/view_model/login_state_cubit/login_state_cubit.dart';
import 'package:plus_cart/features/auth/presentation/view_model/register_state_cubit/register_state_cubit.dart';

void initAuthDependencies() {
  getIt.registerLazySingleton<RemoteAuthDataSource>(
    () => RemoteAuthDataSourceImp(),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(remoteAuthDataSource: getIt.get<RemoteAuthDataSource>()),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => CheckLoginUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => LoginWithGoogleUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => RegisterWithGoogleUseCase(getIt.get<AuthRepo>()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt.get<AuthRepo>()));

  getIt.registerFactory(
    () => LoginStateCubit(
      loginWithGoogleUseCase: getIt.get<LoginWithGoogleUseCase>(),
      loginUseCase: getIt.get<LoginUseCase>(),
      checkLoginUseCase: getIt.get<CheckLoginUseCase>(),
    )..isLoggedIn(),
  );

  getIt.registerFactory(
    () => RegisterStateCubit(
      registerUseCase: getIt.get<RegisterUseCase>(),
      registerWithGoogleUseCase: getIt.get<RegisterWithGoogleUseCase>()
    )
  );
}
