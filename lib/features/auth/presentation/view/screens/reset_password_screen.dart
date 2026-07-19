
import 'package:flutter/material.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/utils/validator.dart';
import 'package:plus_cart/features/auth/presentation/view/widgets/header_info_custom_widget.dart';
import 'package:plus_cart/features/auth/presentation/view/widgets/otp_code_custom_widget.dart';
import 'package:plus_cart/shared/widgets/action_button_custom_widget.dart';
import 'package:plus_cart/shared/widgets/text_form_field_custom_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                const HeaderInfoCustomWidget(
                  title: "Forget Password",
                  subTitle:
                      "Enter your email for the verification process. We will send 4 digits code to your email.",
                ),
                TextFormFieldWithLabelCustomWidget(
                  labelText: "Email",
                  hintText: "Enter Your Email",
                  controller: email,
                  validator: Validator.validateEmail,
                  realtimeChange: true,
                ),
                Center(
                  child: OtpCodeCustomWidget(
                    length: 6,
                    focusColor: AppColors.textPrimary,
                    unfocusColor: AppColors.divider,
                    onCompleted: (v){
                      
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ActionButtonCustomWidget(title: "Send Code", onTap: () {}),
      ),
    );
  }
}
