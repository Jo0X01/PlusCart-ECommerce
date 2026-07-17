
import 'package:flutter/material.dart';
import 'package:plus_cart/shared/widgets/tapped_text_custom_widget.dart';

class BottomNavigateTextCustomWidget extends StatelessWidget {
  const BottomNavigateTextCustomWidget({super.key, required this.titles});
  final Map<String, void Function()?> titles;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: TappedTextCustomWidget(
          textAlign: TextAlign.center,
          titles: titles,
        ),
      ),
    );
  }
}
