import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/constant/app_routes.dart';
import 'package:plus_cart/core/dialogs/app_dialogs.dart';
import 'package:plus_cart/core/utils/validator.dart';
import 'package:plus_cart/features/auth/presentation/view/widgets/bottom_navigate_text_custom_widget.dart';
import 'package:plus_cart/features/auth/presentation/view/widgets/header_info_custom_widget.dart';
import 'package:plus_cart/features/auth/presentation/view/widgets/or_divider_custom_widget.dart';
import 'package:plus_cart/features/auth/presentation/view_model/login_state_cubit/login_state_cubit.dart';
import 'package:plus_cart/shared/widgets/action_button_custom_widget.dart';
import 'package:plus_cart/shared/widgets/tapped_text_custom_widget.dart';
import 'package:plus_cart/shared/widgets/text_form_field_custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                const HeaderInfoCustomWidget(
                  title: "Login To Your Account",
                  subTitle: "It`s great to see you again",
                ),
                loginForm(context),
                loginBtn(),
                const OrDividerCustomWidget(),
                BlocBuilder<LoginStateCubit, LoginState>(
                  buildWhen: (previous, current) =>
                      previous is LoginLoadingState ||
                      current is LoginLoadingState,
                  builder: (context, state) {
                    return ActionOutlineButtonCustomWidget(
                      title: "Login with Google",
                      icon: AppIcons.googleLogo,
                      isLoading: state is LoginLoadingState,
                      prefixIcon: true,
                      onTap: () =>
                          context.read<LoginStateCubit>().loginWithGoogle(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigateTextCustomWidget(
        titles: {
          "Don`t have an account? ": null,
          "Join Us": () => context.go(AppRoutes.registerScreen),
        },
      ),
    );
  }

  BlocConsumer<LoginStateCubit, LoginState> loginBtn() {
    return BlocConsumer<LoginStateCubit, LoginState>(
      buildWhen: (previous, current) {
        return (current is LoginLoadingState ||
            current is CheckInputState ||
            previous is LoginLoadingState ||
            previous is CheckInputState);
      },
      listener: (context, state) {
        if (state is LoginFailureState) {
          AppDialogs.showSnackBar(context, msg: state.msg);
        } else if (state is LoginSuccessState ||
            state is AlreadyLoggedInState) {
          context.go(AppRoutes.homeScreen);
        }
      },
      builder: (context, state) => ActionButtonCustomWidget(
        title: "Login",
        isLoading: state is LoginLoadingState,
        enable:
            state is CheckInputState &&
            state.isPasswordValid &&
            state.isEmailValid,
        onTap: () {
          context.read<LoginStateCubit>().login(
            email: email.text,
            password: password.text,
          );
        },
      ),
    );
  }

  Column loginForm(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        TextFormFieldWithLabelCustomWidget(
          labelText: "Email",
          hintText: "Enter Your Email",
          controller: email,
          validator: Validator.validateEmail,
          realtimeChange: true,
          onValidationChanged: (val) =>
              context.read<LoginStateCubit>().onEmailInput(val),
        ),
        TextFormFieldWithLabelCustomWidget(
          labelText: "Password",
          hintText: "Enter Your Password",
          controller: password,
          validator: Validator.validatePassword,
          realtimeChange: true,
          isPassword: true,
          onValidationChanged: context.read<LoginStateCubit>().onPasswordInput,
        ),
        TappedTextCustomWidget(
          titles: {
            'Forget Your Password? ': null,
            'Reset your password': () =>
                context.push(AppRoutes.frogetPasswordScreen),
          },
        ),
      ],
    );
  }
}
