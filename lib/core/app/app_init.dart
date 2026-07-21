import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plus_cart/core/constant/app_strings.dart';
import 'package:plus_cart/core/services/env_service.dart';
import 'package:plus_cart/core/services/google_sign_in_service.dart';
import 'package:plus_cart/core/services/supabase_service.dart';
import 'package:plus_cart/features/auth/di/auth_injection.dart';
import 'package:plus_cart/features/onboarding/di/startup_injection.dart';
import 'package:plus_cart/firebase_options.dart';
import 'package:plus_cart/core/bloc/simple_bloc_observer.dart';

final getIt = GetIt.instance;

Future<void> appInit() async {
  final envService = await EnvService.init();
  Bloc.observer = SimpleBlocObserver();

  final supabaseService = await SupabaseService.init(
    publishableKey: envService.get(AppStrings.supabaseAnonKey),
    url: envService.get(AppStrings.supabaseUrl)!,
  );
  final googleSignInService = await GoogleSignInService.init(
    clientId: envService.get(AppStrings.googleWebOauthClientId)!,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  getIt.registerSingleton<SupabaseService>(supabaseService);
  getIt.registerSingleton<GoogleSignInService>(googleSignInService);

  initStartupDependencies(getIt);
  initAuthDependencies(getIt);
}
