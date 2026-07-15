import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 10,
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
                        onChanged: (val) => setState(() {}),
                      ),
                      const SizedBox(height: 2),
                      TappedTextCustomWidget(
                        title: 'Forget Your Password? ',
                        tappedTitle: 'Reset your password',
                        onTap: () {},
                      ),
                      ActionButtonCustomWidget(
                        title: "Login",
                        enable: _formKey.currentState?.validate() ?? false,
                        onTap: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
