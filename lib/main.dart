import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_cart/core/constant/app_routes.dart';
import 'package:plus_cart/core/services/service_alocator.dart';
import 'package:plus_cart/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await initSingleton();
  runApp(const PlusCartApp());
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
