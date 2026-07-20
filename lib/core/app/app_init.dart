import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plus_cart/core/services/google_sign_in_service.dart';
import 'package:plus_cart/core/services/supabase_service.dart';
import 'package:plus_cart/features/auth/di/auth_injection.dart';
import 'package:plus_cart/features/onboarding/di/startup_injection.dart';
import 'package:plus_cart/firebase_options.dart';
import 'package:plus_cart/core/bloc/simple_bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

Future<void> appInit() async {
  await dotenv.load();
  Bloc.observer = SimpleBlocObserver();
  final supabaseService = SupabaseService();
  final googleSignInService = GoogleSignInService();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await supabaseService.init(
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
    url: dotenv.env['SUPABASE_URL']!,
  );
  await googleSignInService.init(
    clientId: dotenv.env['GOOGLE_WEB_OAUTH_CLIENT_ID']!,
  );

  getIt.registerSingleton<SupabaseService>(supabaseService);
  getIt.registerSingleton<GoogleSignInService>(googleSignInService);

  initAuthDependencies(getIt);
  initStartupDependencies(getIt);
}
