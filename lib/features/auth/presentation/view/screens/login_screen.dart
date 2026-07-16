import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/constant/app_routes.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';
import 'package:plus_cart/core/utils/validator.dart';
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:plus_cart/features/auth/presentation/view_model/login_state_cubit/login_state_cubit.dart';
import 'package:plus_cart/shared/widgets/action_button_custom_widget.dart';
import 'package:plus_cart/shared/widgets/app_loading_indicator.dart';
import 'package:plus_cart/shared/widgets/tapped_text_custom_widget.dart';
import 'package:plus_cart/shared/widgets/text_form_field_custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "Login To Your Account",
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "It`s great to see you again",
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16,
                    children: [
                      TextFormFieldWithLabelCustomWidget(
                        labelText: "Email",
                        controller: _email,
                        hintText: "Enter Your Email",
                        validator: Validator.validateEmail,
                        realtimeChange: true,
                        onChanged: BlocProvider.of<LoginStateCubit>(
                          context,
                        ).onInput,
                      ),
                      TextFormFieldWithLabelCustomWidget(
                        labelText: "Password",
                        controller: _password,
                        hintText: "Enter Your Password",
                        validator: Validator.validatePassword,
                        realtimeChange: true,
                        isPassword: true,
                        onChanged: BlocProvider.of<LoginStateCubit>(
                          context,
                        ).onInput,
                      ),
                      TappedTextCustomWidget(
                        titles: {
                          'Forget Your Password? ': null,
                          'Reset your password': () {},
                        },
                      ),
                    ],
                  ),
                ),
                BlocListener<LoginStateCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      AppLoadingIndicator.show(
                        context: context,
                        text: "Loading ...",
                        // size: 25,
                        // strokeWidth: 2.5
                      );
                    }
                  },
                  child: ActionButtonCustomWidget(
                    title: "Login",
                    enable: _formKey.currentState?.validate() ?? false,
                    onTap: () {
                      BlocProvider.of<LoginStateCubit>(context).login(
                        UserEntity(
                          email: _email.text,
                          password: _password.text,
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(color: AppColors.divider)),
                    Text(
                      "Or",
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.divider,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.divider)),
                  ],
                ),
                ActionOutlineButtonCustomWidget(
                  title: "Login with Google",
                  icon: AppIcons.googleLogo,
                  prefixIcon: true,
                  onTap: BlocProvider.of<LoginStateCubit>(
                    context,
                  ).loginWithGoogle,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: TappedTextCustomWidget(
          textAlign: TextAlign.center,
          titles: {
            "Don`t have an account? ": null,
            "Join Us": () => context.go(AppRoutes.registerScreen),
          },
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
