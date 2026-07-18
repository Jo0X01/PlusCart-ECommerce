import 'package:flutter/material.dart';
import 'package:plus_cart/core/app/app_init.dart';
import 'package:plus_cart/core/constant/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInit();
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
