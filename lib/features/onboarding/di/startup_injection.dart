import 'package:get_it/get_it.dart';
import 'package:plus_cart/core/services/supabase_service.dart';
import 'package:plus_cart/features/onboarding/data/data_source/remote/remote_app_startup_data_source.dart';
import 'package:plus_cart/features/onboarding/data/data_source/remote/remote_app_startup_data_source_imp.dart';
import 'package:plus_cart/features/onboarding/data/repos/startup_repo_imp.dart';
import 'package:plus_cart/features/onboarding/domain/repos/startup_repo.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/get_current_user_use_case.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/is_login_use_case.dart';
import 'package:plus_cart/features/onboarding/domain/usecases/is_logout_use_case.dart';
import 'package:plus_cart/features/onboarding/presentation/view_model/app_startup_cubit/app_startup_cubit.dart';

void initStartupDependencies(GetIt getIt) {
  getIt.registerLazySingleton<RemoteAppStartupDataSource>(
    () => RemoteAppStartupDataSourceImp(
      supabaseService: getIt.get<SupabaseService>(),
    ),
  );

  getIt.registerLazySingleton<StartupRepo>(
    () => StartupRepoImp(
      remoteAppStartupDataSource: getIt.get<RemoteAppStartupDataSource>(),
    ),
  );
  getIt.registerLazySingleton<IsLoginUseCase>(
    () => IsLoginUseCase(startupRepo: getIt.get<StartupRepo>()),
  );
  getIt.registerLazySingleton<IsLogoutUseCase>(
    () => IsLogoutUseCase(startupRepo: getIt.get<StartupRepo>()),
  );
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(startupRepo: getIt.get<StartupRepo>()),
  );

  getIt.registerFactory<AppStartupCubit>(
    () => AppStartupCubit(
      isLoginUseCase: getIt.get<IsLoginUseCase>(),
      isLogoutUseCase: getIt.get<IsLogoutUseCase>(),
      getCurrentUserUseCase: getIt.get<GetCurrentUserUseCase>(),
    ),
  );
}
