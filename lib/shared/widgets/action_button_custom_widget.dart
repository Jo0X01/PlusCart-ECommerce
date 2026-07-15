import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plus_cart/core/theme/app_button_style.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';

class ActionButtonCustomWidget extends StatelessWidget {
  const ActionButtonCustomWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.enable = true,
  });

  final bool enable;
  final String title;
  final String? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable? onTap:null,
      style: AppButtonStyles.primary,
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.buttonBlack
          ),
          if (icon != null)
            SvgPicture.asset(
              icon!,
              colorFilter: ColorFilter.mode(
                AppColors.background,
                BlendMode.srcIn,
              ),
            ),
        ],
      ),
    );
  }
}
