import 'package:flutter/material.dart';
import 'package:plus_cart/core/constant/app_routes.dart';

void main() {
  runApp(const PlusCartApp());
}

class PlusCartApp extends StatelessWidget {
  const PlusCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRoutes);
  }
}
