import 'package:flutter/material.dart';
import 'package:plus_cart/core/constant/app_assets.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/theme/app_text_style.dart';
import 'package:plus_cart/core/utils/validator.dart';
import 'package:plus_cart/shared/widgets/action_button_custom_widget.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        onChanged: (val) => setState(() {}),
                      ),
                      TextFormFieldWithLabelCustomWidget(
                        labelText: "Password",
                        controller: _password,
                        hintText: "Enter Your Password",
                        validator: Validator.validatePassword,
                        realtimeChange: true,
                        isPassword: true,
                        onChanged: (val) => setState(() {}),
                      ),
                      TappedTextCustomWidget(
                        title: 'Forget Your Password? ',
                        tappedTitle: 'Reset your password',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                ActionButtonCustomWidget(
                  title: "Login",
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
                  title: "Login with Google",
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TappedTextCustomWidget(
          title: "Don`t have an account? ",
          tappedTitle: "Join Us",
          mainAxisAlignment: MainAxisAlignment.center,
          onTap: () {},
        ),
        // bottomNavigationBar: ,
      ),
    );
  }
}
