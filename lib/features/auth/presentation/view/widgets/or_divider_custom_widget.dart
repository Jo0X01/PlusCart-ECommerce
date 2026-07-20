import 'package:flutter/material.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';

class OrDividerCustomWidget extends StatelessWidget {
  const OrDividerCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: AppColors.divider)),
        Text(
          "Or",
          style: AppTextStyles.label.copyWith(
            color: AppColors.divider,
            fontSize: 14,
          ),
        ),
        Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }
}
