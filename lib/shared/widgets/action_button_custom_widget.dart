import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plus_cart/core/theme/app_button_style.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';
import 'package:plus_cart/shared/widgets/app_loading_indicator.dart';

class ActionButtonCustomWidget extends StatelessWidget {
  const ActionButtonCustomWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.enable = true,
    this.isLoading,
  });

  final bool enable;
  final String title;
  final String? icon;
  final bool? isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable ? (isLoading == true ? null : onTap) : null,
      style: AppButtonStyles.primary,
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLoading != true)
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.buttonBlack,
            ),
          if (isLoading != true && icon != null)
            SvgPicture.asset(
              icon!,
              colorFilter: ColorFilter.mode(
                AppColors.background,
                BlendMode.srcIn,
              ),
            ),

          if (isLoading == true)
            AppLoadingIndicator(size: 22, strokeWidth: 1.5),
        ],
      ),
    );
  }
}

class ActionOutlineButtonCustomWidget extends StatelessWidget {
  const ActionOutlineButtonCustomWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.enable = true,
    this.prefixIcon = false,
    this.isLoading,
  });

  final bool? isLoading;
  final bool prefixIcon;
  final bool enable;
  final String title;
  final String? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enable ? (isLoading == true ? null : onTap) : null,
      style: AppButtonStyles.secondary,
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLoading != true && prefixIcon)
            SvgPicture.asset(
              icon!,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          if (isLoading != true)
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.buttonLight,
            ),
          if (isLoading != true && icon != null && !prefixIcon)
            SvgPicture.asset(
              icon!,
              colorFilter: ColorFilter.mode(
                AppColors.background,
                BlendMode.srcIn,
              ),
            ),

          if (isLoading == true)
            AppLoadingIndicator(size: 22, strokeWidth: 1.5),
        ],
      ),
    );
  }
}
