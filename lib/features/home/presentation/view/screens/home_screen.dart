import 'package:flutter/material.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';
import 'package:plus_cart/shared/widgets/icon_with_counter_badge_custom_widget.dart';
import 'package:plus_cart/shared/widgets/search_bar_custom_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeTopBar(),
        SearchBarCustomWidget(
          enableVoice: true,
          enableFilter: true,
        ),

        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) =>
                Text("I: $index", style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Discover", style: AppTextStyles.headlineLarge),
          IconWithCounterBadgeCustomWidget(
            onTap: () {},
            count: 100,
            maxCount: 50,
            icon: AppIcons.bell
          ),
        ],
      ),
    );
  }
}
