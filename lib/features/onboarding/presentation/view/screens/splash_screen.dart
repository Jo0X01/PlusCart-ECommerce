import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/constant/app_routes.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/shared/widgets/app_loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.sizeOf(context).height * 0.75,
            child: Image.asset(
              AppImages.splashEffect,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          Column(
            children: [
              const Spacer(flex: 3),
              SvgPicture.asset(AppIcons.appLogo, width: 130, height: 130),
              const Spacer(flex: 2),
              Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: AppLoadingIndicator(
                    timeout: Duration(seconds: 3),
                    onTimeoutDone: (context){
                      context.go(AppRoutes.onBoardingScreen);
                    }
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
