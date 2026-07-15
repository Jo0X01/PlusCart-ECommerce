import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source.dart';
import 'package:plus_cart/features/auth/data/data_source/remote/remote_auth_data_source_imp.dart';
import 'package:plus_cart/features/auth/data/repos/auth_repo_imp.dart';
import 'package:plus_cart/features/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

initSingleton() async {
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  getIt.registerSingleton<RemoteAuthDataSource>(RemoteAuthDataSourceImp());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(remoteAuthDataSource: getIt.get<RemoteAuthDataSource>()),
  );
}
