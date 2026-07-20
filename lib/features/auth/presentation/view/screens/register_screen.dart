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
import 'package:plus_cart/features/auth/presentation/view_model/register_state_cubit/register_state_cubit.dart';
import 'package:plus_cart/shared/widgets/action_button_custom_widget.dart';
import 'package:plus_cart/shared/widgets/tapped_text_custom_widget.dart';
import 'package:plus_cart/shared/widgets/text_form_field_custom_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _fullName;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _fullName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _fullName.dispose();
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
                HeaderInfoCustomWidget(
                  title: "Create An Account",
                  subTitle: "Let’s create your account.",
                ),
                registerForm(),
                BlocConsumer<RegisterStateCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterFailureState) {
                      AppDialogs.showSnackBar(context, msg: state.msg);
                    } else if (state is RegisterSuccessState) {
                      AppDialogs.showSnackBar(
                        context,
                        msg: "User Registered, Login Now",
                      );
                      context.go(AppRoutes.loginScreen);
                    }
                  },
                  builder: (context, state) => ActionButtonCustomWidget(
                    title: "Sign Up",
                    isLoading: state is RegisterLoadingState,
                    enable: state is RegisterCheckInputState && state.isValid,
                    onTap: () {
                      context.read<RegisterStateCubit>().register(
                        fullName: _fullName.text,
                        email: _email.text,
                        password: _password.text,
                      );
                    },
                  ),
                ),
                const OrDividerCustomWidget(),
                BlocBuilder<RegisterStateCubit, RegisterState>(
                  builder: (context, state) => ActionOutlineButtonCustomWidget(
                    title: "SignUp with Google",
                    icon: AppIcons.googleLogo,
                    prefixIcon: true,
                    isLoading: state is RegisterLoadingState,
                    onTap: () {
                      context.read<RegisterStateCubit>().registerWithGoogle();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigateTextCustomWidget(
        titles: {
          "have an account? ": null,
          "Login": () => context.go(AppRoutes.loginScreen),
        },
      ),

      // bottomNavigationBar: ,
    );
  }

  Widget registerForm() {
    return Column(
      spacing: 16,
      children: [
        TextFormFieldWithLabelCustomWidget(
          labelText: "Full Name",
          controller: _fullName,
          hintText: "Enter Your Full Name",
          validator: Validator.validateName,
          realtimeChange: true,
          onValidationChanged: context
              .read<RegisterStateCubit>()
              .onFullNameInput,
        ),
        TextFormFieldWithLabelCustomWidget(
          labelText: "Email",
          controller: _email,
          hintText: "Enter Your Email",
          validator: Validator.validateEmail,
          realtimeChange: true,
          onValidationChanged: context.read<RegisterStateCubit>().onEmailInput,
        ),
        TextFormFieldWithLabelCustomWidget(
          labelText: "Password",
          controller: _password,
          hintText: "Enter Your Password",
          validator: Validator.validatePassword,
          realtimeChange: true,
          isPassword: true,
          onValidationChanged: context
              .read<RegisterStateCubit>()
              .onPasswordInput,
        ),
        TappedTextCustomWidget(
          titles: {
            'By signing up you agree to ': null,
            'our ': null,
            'Terms': () {},
            ', ': null,
            "Privacy Policy": () {},
            ", and ": null,
            "Cookie Use": () {},
          },
        ),
      ],
    );
  }
}
