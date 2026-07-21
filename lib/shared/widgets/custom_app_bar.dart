import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.hasBack = true,
    this.justGoBack = false,
    this.onBackPressed,
    this.iconSize = 24,
    this.fontSize = 16,
  });

  final String? title;
  final bool hasBack;
  final bool justGoBack;
  final VoidCallback? onBackPressed;
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBack)
            GestureDetector(
              onTap: () {
                onBackPressed?.call();
                if (justGoBack) {
                  context.pop();
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: SvgPicture.asset(
                  AppIcons.arrow,
                  matchTextDirection: true,
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          if (title != null)
            Text(
              title!,
              style: TextStyle(fontSize: fontSize, color: AppColors.primary),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
        ],
      ),
    );

    // AppBar(
    //   leadingWidth: screenWidth * 0.12,
    //   leading: !hasBack
    //       ? null
    //       : ,
    //   automaticallyImplyLeading: false,
    //   centerTitle: true,
    //   forceMaterialTransparency: true,
    //   title: title == null
    //       ? null
    //       : Text(
    //           title!,
    //           style: TextStyle(fontSize: fontSize),
    //           overflow: TextOverflow.ellipsis,
    //           maxLines: 1,
    //         ),
    //   actionsPadding: EdgeInsets.symmetric(horizontal: 10),
    //   actions: [
    //     if (addSettings)
    //       Container(
    //         margin: const EdgeInsets.symmetric(horizontal: 10),
    //         child: GestureDetector(
    //           onTap: context.pop,
    //           child: SvgPicture.asset(
    //             AppIcons.bell,
    //             width: iconSize,
    //             height: iconSize,
    //             colorFilter: ColorFilter.mode(
    //               Theme.of(context).colorScheme.primary,
    //               BlendMode.srcIn,
    //             ),
    //           ),
    //         ),
    //       ),
    //   ],
    // );
  }
}
