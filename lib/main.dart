import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/core/app/app_init.dart';
import 'package:plus_cart/core/constant/app_routes.dart';
import 'package:plus_cart/features/onboarding/presentation/view_model/app_startup_cubit/app_startup_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInit();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppStartupCubit(
            isLoginUseCase: getIt.get(),
            isLogoutUseCase: getIt.get(),
            getCurrentUserUseCase: getIt.get(),
          )
        ),
      ],
      child: const PlusCartApp(),
    ),
  );
}

class PlusCartApp extends StatelessWidget {
  const PlusCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
      theme: ThemeData.light(),
    );
  }
}
