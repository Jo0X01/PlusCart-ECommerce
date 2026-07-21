import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWithCounterBadgeCustomWidget extends StatelessWidget {
  const IconWithCounterBadgeCustomWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.count = 0,
    this.badgeColor = Colors.red,
    this.badgeTextColor = Colors.white,
    this.badgeSize = 16,
    this.maxCount = 5,
    this.showZero = false,
  });

  final String icon;
  final VoidCallback onTap;
  final int count;
  final Color badgeColor;
  final Color badgeTextColor;
  final double badgeSize;
  final int maxCount;
  final bool showZero;

  @override
  Widget build(BuildContext context) {
    final shouldShow = count > 0 || (count == 0 && showZero);
    final displayText = count > maxCount ? '$maxCount+' : '$count';

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(icon, width: 25, height: 25, fit: BoxFit.fill),
          if (shouldShow)
            Positioned(
              right: -6,
              top: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                constraints: BoxConstraints(
                  minWidth: badgeSize,
                  minHeight: badgeSize,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(badgeSize / 2),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  displayText,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontSize: badgeSize * 0.6,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
