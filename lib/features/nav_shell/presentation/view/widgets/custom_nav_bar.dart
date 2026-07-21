import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.fabIndex,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
    this.fabColor = Colors.black,
    this.iconSize = 22,
    this.fabIconSize = 22,
    this.labelFontSize = 11,
    this.labelSpacing = 6,
    this.iconSpacing,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.fabPadding = const EdgeInsets.all(14),
    this.barPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.barColor = Colors.white,
    this.borderRadius,
    this.showLabels = true,
    this.showSelectedLabelOnly = false,
  });

  final Map<String, String> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  final int? fabIndex;

  final Color activeColor;
  final Color inactiveColor;
  final Color fabColor;

  final double? iconSpacing;
  final double labelSpacing;

  final double iconSize;
  final double fabIconSize;
  final double labelFontSize;

  final EdgeInsets itemPadding;
  final EdgeInsets fabPadding;
  final EdgeInsets barPadding;

  final Color barColor;
  final BorderRadius? borderRadius;

  final bool showLabels;

  final bool showSelectedLabelOnly;

  @override
  Widget build(BuildContext context) {
    final entries = items.entries.toList();

    return Container(
      padding: barPadding,
      decoration: BoxDecoration(
        color: barColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: activeColor.withValues(alpha: 0.6),
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Wrap(
          spacing: iconSpacing ?? 0.0,
          alignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: List.generate(entries.length, (index) {
            final label = entries[index].key;
            final svgPath = entries[index].value;
            final isSelected = index == currentIndex;
            final isFab = index == fabIndex;
            return _NavItem(
              label: label,
              svgPath: svgPath,
              isSelected: isSelected,
              isFab: isFab,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              fabColor: fabColor,
              iconSize: iconSize,
              fabIconSize: fabIconSize,
              labelFontSize: labelFontSize,
              labelSpacing: labelSpacing,
              itemPadding: itemPadding,
              fabPadding: fabPadding,
              showLabel: showLabels && (!showSelectedLabelOnly || isSelected),
              onTap: () => onTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.svgPath,
    required this.isSelected,
    required this.isFab,
    required this.activeColor,
    required this.inactiveColor,
    required this.fabColor,
    required this.iconSize,
    required this.fabIconSize,
    required this.labelFontSize,
    required this.labelSpacing,
    required this.itemPadding,
    required this.fabPadding,
    required this.showLabel,
    required this.onTap,
  });

  final String label;
  final String svgPath;
  final bool isSelected;
  final bool isFab;
  final Color activeColor;
  final Color inactiveColor;
  final Color fabColor;
  final double iconSize;
  final double fabIconSize;
  final double labelFontSize;
  final double labelSpacing;
  final EdgeInsets itemPadding;
  final EdgeInsets fabPadding;
  final bool showLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (isFab) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: fabPadding,
          decoration: BoxDecoration(
            color: fabColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: fabColor.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SvgPicture.asset(
            svgPath,
            width: fabIconSize,
            height: fabIconSize,
            colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
          ),
        ),
      );
    }

    final color = isSelected ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: itemPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              width: iconSize,
              height: iconSize,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            if (showLabel) ...[
              SizedBox(height: labelSpacing),
              Text(
                label,
                style: TextStyle(
                  fontSize: labelFontSize,
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
