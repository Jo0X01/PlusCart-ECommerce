
import 'package:flutter/material.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';

class HeaderInfoCustomWidget extends StatelessWidget {
  const HeaderInfoCustomWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(subTitle, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}
