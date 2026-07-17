import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/constant/app_routes.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';
import 'package:plus_cart/core/utils/validator.dart';
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
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "Create an account",
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Let’s create your account.",
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
                        labelText: "Full Name",
                        controller: _fullName,
                        hintText: "Enter Your Full Name",
                        validator: Validator.validateName,
                        realtimeChange: true,
                        // onChanged: (val) => setState(() {}),
                      ),
                      TextFormFieldWithLabelCustomWidget(
                        labelText: "Email",
                        controller: _email,
                        hintText: "Enter Your Email",
                        validator: Validator.validateEmail,
                        realtimeChange: true,
                        // onChanged: (val) => setState(() {}),
                      ),
                      TextFormFieldWithLabelCustomWidget(
                        labelText: "Password",
                        controller: _password,
                        hintText: "Enter Your Password",
                        validator: Validator.validatePassword,
                        realtimeChange: true,
                        isPassword: true,
                        // onChanged: (val) => setState(() {}),
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
                  ),
                ),
                ActionButtonCustomWidget(
                  title: "Sign Up",
                  enable: _formKey.currentState?.validate() ?? false,
                  onTap: () {
                    setState(() {});
                  },
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
                  title: "SignUp with Google",
                  icon: AppIcons.googleLogo,
                  prefixIcon: true,
                  onTap: () {
                    setState(() {});
                  },
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
            "have an account? ": null,
            "Login": () => context.go(AppRoutes.loginScreen),
          },
        ),
      ),

      // bottomNavigationBar: ,
    );
  }
}
