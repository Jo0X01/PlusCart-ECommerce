import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';

class TappedTextCustomWidget extends StatelessWidget {
  const TappedTextCustomWidget({
    super.key,
    required this.titles,
    this.textAlign,
  });

  final TextAlign? textAlign;
  final Map<String, VoidCallback?> titles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text.rich(
        textAlign: textAlign ?? TextAlign.start,
        _buildText(
          title: titles.entries.first.key,
          onTap: titles.entries.first.value,
          children: titles.entries
              .skip(1)
              .map<TextSpan>(
                (entry) => _buildText(title: entry.key, onTap: entry.value),
              )
              .toList(),
        ),
      ),
    );
  }

  TextSpan _buildText({
    required String title,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      text: title,
      style: AppTextStyles.label.copyWith(
        decoration: onTap == null ? null : TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
      children: children,
    );
  }
}
