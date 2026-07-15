import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:plus_cart/features/auth/di/auth_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

initSingleton() async {
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  initAuthDependencies();
}
