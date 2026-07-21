import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/features/nav_shell/presentation/view/widgets/custom_nav_bar.dart';

class NavigationShell extends StatelessWidget {
  const NavigationShell({
    super.key,
    required this.navigationShell,
    required this.items,
  });
  final StatefulNavigationShell navigationShell;
  final Map<String, String> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: CustomBottomNavBar(
        activeColor: AppColors.primary,
        inactiveColor: AppColors.textHint,
        barColor: AppColors.background,
        iconSize: 24,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: items,
      ),
    );
  }
}
