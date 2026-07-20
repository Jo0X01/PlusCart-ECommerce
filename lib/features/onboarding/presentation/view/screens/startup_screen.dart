import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/constant/app_routes.dart';
import 'package:plus_cart/core/dialogs/app_dialogs.dart';
import 'package:plus_cart/features/onboarding/presentation/view/widgets/onboarding_body.dart';
import 'package:plus_cart/features/onboarding/presentation/view/widgets/splash_body.dart';
import 'package:plus_cart/features/onboarding/presentation/view_model/app_startup_cubit/app_startup_cubit.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppStartupCubit, AppStartupState>(
      buildWhen: (previous, current) {
        return current is AppStartupGoToOnboardingState ||
            current is AppStartupGoToSplashState ||
            current is AppStartupFailureState;
      },
      listener: (context, state) {
        if (state is AppStartupFailureState) {
          AppDialogs.showSnackBar(context, msg: state.msg);
        } else if (state is AppStartupGoToHomeState) {
          context.go(AppRoutes.homeScreen);
        } else if (state is AppStartupGoToLoginState) {
          context.go(AppRoutes.loginScreen);
        }
      },
      builder: (context, state) {
        if (state is AppStartupGoToOnboardingState) {
          return OnBoardingBody();
        }
        return SplashBody(
          onTimeoutDone: (context) {
            context.read<AppStartupCubit>().checkStartup();
          },
        );
      },
    );
  }
}
