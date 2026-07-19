import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_cart/core/dialogs/app_dialogs.dart';
import 'package:plus_cart/core/theme/app_colors.dart';
import 'package:plus_cart/core/utils/validator.dart';
import 'package:plus_cart/features/auth/presentation/view/widgets/header_info_custom_widget.dart';
import 'package:plus_cart/features/auth/presentation/view/widgets/otp_code_custom_widget.dart';
import 'package:plus_cart/features/auth/presentation/view_model/reset_password_cubit/reset_password_cubit.dart';
import 'package:plus_cart/shared/widgets/action_button_custom_widget.dart';
import 'package:plus_cart/shared/widgets/text_form_field_custom_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPass;
  late final TextEditingController otp;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmPass = TextEditingController();
    otp = TextEditingController();
  }

  @override
  void dispose() {
    otp.dispose();
    email.dispose();
    password.dispose();
    confirmPass.dispose();
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
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  buildWhen: (previous, current) {
                    return current is ResetPasswordEnterOtpState ||
                        current is ResetPasswordEnterEmailState ||
                        current is ResetPasswordEnterPasswordState;
                  },
                  builder: (context, state) {
                    var title = "Forgot Your Password?";
                    var text =
                        "No worries, enter your email and we'll send you a 6-digit code to reset it.";
                    if (state is ResetPasswordEnterPasswordState) {
                      title = "Create a New Password";
                      text =
                          "Almost done! Choose a new password to secure your account.";
                    }
                    if (state is ResetPasswordEnterOtpState) {
                      title = "Check Your Email";
                      text =
                          "We sent a 6-digit code to ${state.email}. Enter it below to continue.";
                    }
                    return HeaderInfoCustomWidget(title: title, subTitle: text);
                  },
                ),

                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  buildWhen: (previous, current) {
                    return current is ResetPasswordEnterOtpState ||
                        current is ResetPasswordEnterEmailState ||
                        current is ResetPasswordEnterPasswordState;
                  },
                  builder: (context, state) {
                    if (state is ResetPasswordEnterOtpState) {
                      return _otpField();
                    }
                    if (state is ResetPasswordEnterPasswordState) {
                      return _passwordField();
                    }
                    return _emailField();
                  },
                ),
                BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                  buildWhen: (previous, current) =>
                      (previous is! ResetPasswordSuccessState &&
                          previous is! ResetPasswordFailureState) ||
                      (current is! ResetPasswordSuccessState &&
                          current is! ResetPasswordFailureState),
                  listener: (context, state) {
                    if (state is ResetPasswordEnterOtpState) {
                      AppDialogs.showSnackBar(
                        context,
                        msg:
                            "We've sent a code to ${state.email}. Check your inbox.",
                      );
                    } else if (state is ResetPasswordSuccessState) {
                      AppDialogs.showSnackBar(
                        context,
                        msg:
                            "Your password has been changed. Log in with your new password.",
                      );
                      context.pop();
                    } else if (state is ResetPasswordFailureState) {
                      AppDialogs.showSnackBar(context, msg: state.msg);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ActionButtonCustomWidget(
                        title: state is ResetPasswordEnterEmailState
                            ? "Send Code"
                            : "Continue",
                        isLoading: state is ResetPasswordLoadingState,
                        enable:
                            state is ResetPasswordValidInputState &&
                            state.valid,
                        onTap: () {
                          final cstate = context
                              .read<ResetPasswordCubit>()
                              .currentStep;
                          switch (cstate) {
                            case ResetPasswordStep.email:
                              BlocProvider.of<ResetPasswordCubit>(
                                context,
                              ).sendConfirmCode(email: email.text);
                            case ResetPasswordStep.otp:
                              BlocProvider.of<ResetPasswordCubit>(
                                context,
                              ).verfiyOtpCode(
                                email: email.text,
                                code: otp.text,
                              );
                            case ResetPasswordStep.password:
                              BlocProvider.of<ResetPasswordCubit>(
                                context,
                              ).updatePassword(
                                password: password.text,
                                cPassword: confirmPass.text,
                              );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: ,
    );
  }

  Widget _emailField() => TextFormFieldWithLabelCustomWidget(
    labelText: "Email",
    hintText: "Enter Your Email",
    controller: email,
    validator: Validator.validateEmail,
    realtimeChange: true,
    onValidationChanged: BlocProvider.of<ResetPasswordCubit>(
      context,
    ).onValidateEmail,
  );

  Widget _otpField() => Center(
    child: OtpCodeCustomWidget(
      title: "Code Not Received? ",
      resendSubtitle: "Resend Code",
      resendCooldownSeconds: 30,
      controller: otp,
      length: 6,
      focusColor: AppColors.textPrimary,
      unfocusColor: AppColors.divider,
      onCompleted: (v) =>
          BlocProvider.of<ResetPasswordCubit>(context).onOtpCompelete(v),
      onResend: () => BlocProvider.of<ResetPasswordCubit>(
        context,
      ).sendConfirmCode(email: email.text),
    ),
  );

  Widget _passwordField() {
    return Column(
      spacing: 16,
      children: [
        TextFormFieldWithLabelCustomWidget(
          labelText: "Password",
          hintText: "Enter Your Password",
          controller: password,
          validator: Validator.validatePassword,
          realtimeChange: true,
          isPassword: true,
          onValidationChanged: context
              .read<ResetPasswordCubit>()
              .onValidatePassword,
        ),
        TextFormFieldWithLabelCustomWidget(
          labelText: "Confirm Password",
          hintText: "Re-Enter Password",
          controller: confirmPass,
          validator: Validator.validatePassword,
          realtimeChange: true,
          isPassword: true,
          onValidationChanged: context
              .read<ResetPasswordCubit>()
              .onValidateConfirmPassword,
        ),
      ],
    );
  }
}
