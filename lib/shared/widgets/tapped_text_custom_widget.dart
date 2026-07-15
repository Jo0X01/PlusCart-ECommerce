import 'package:flutter/widgets.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';

class TappedTextCustomWidget extends StatelessWidget {
  const TappedTextCustomWidget({
    super.key,
    required this.title,
    required this.tappedTitle,
    required this.onTap,
    this.mainAxisAlignment,
  });

  final MainAxisAlignment? mainAxisAlignment;
  final String title;
  final String tappedTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.label),
        GestureDetector(
          onTap: onTap,
          child: Text(
            tappedTitle,
            style: AppTextStyles.label.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
