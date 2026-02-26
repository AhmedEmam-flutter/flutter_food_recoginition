import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_recoginition/core/diauth/service_locator.dart';
import 'package:flutter_food_recoginition/core/utiles/color_manager.dart';
import 'package:flutter_food_recoginition/features/auth/presention/cubit/authcubit_cubit.dart';
import 'package:flutter_food_recoginition/features/auth/presention/cubit/authcubit_state.dart';

import '../../../../core/widgets/auth_background.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  String? emailError;
  String? passError;
  String? confirmError;

  void validateEmail(String val) {
    final bool emailValid =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val);
    setState(() {
      emailError = (val.isEmpty || emailValid) ? null : "Invalid email format";
    });
  }

  void validatePassword(String val) {
    final bool passValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(val);
    setState(() {
      passError = (val.isEmpty || passValid)
          ? null
          : "Must have upper, lower, symbol (@#) and 8+ chars";
    });
    if (confirm.text.isNotEmpty) validateConfirm(confirm.text);
  }

  void validateConfirm(String val) {
    setState(() {
      confirmError = (val.isEmpty || val == password.text)
          ? null
          : "Passwords do not match";
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;
    final formWidth = w * 0.88;

    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: AuthBackground(
          child: SafeArea(
            child: BlocListener<AuthCubit, AuthState>(
              listenWhen: (p, c) => p.user != c.user || p.error != c.error,
              listener: (context, state) {
                if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error!)),
                  );
                  context.read<AuthCubit>().clearError();
                }
                if (state.user != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/setup', (_) => false);
                }
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                      ),
                      SizedBox(height: h * 0.15),
                      Text(
                        "Welcome to CalorieCalc AI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorManager.primaryColor,
                          fontSize: w * 0.042,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: h * 0.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ? ",
                            style: TextStyle(
                              color: ColorManager.lightGrey.withOpacity(0.85),
                              fontSize: w * 0.030,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: ColorManager.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: w * 0.030,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.025),
                      SizedBox(
                        width: formWidth,
                        child: Column(
                          children: [
                            AppTextField(
                              controller: name,
                              hint: "Enter your full name",
                            ),
                            SizedBox(height: h * 0.014),
                            AppTextField(
                              controller: email,
                              hint: "Enter your Email",
                              keyboardType: TextInputType.emailAddress,
                              onChanged: validateEmail,
                              errorText: emailError,
                            ),
                            SizedBox(height: h * 0.014),
                            AppTextField(
                              controller: password,
                              hint: "Enter Password",
                              obscure: true,
                              onChanged: validatePassword,
                              errorText: passError,
                            ),
                            SizedBox(height: h * 0.014),
                            AppTextField(
                              controller: confirm,
                              hint: "Confirm password",
                              obscure: true,
                              onChanged: validateConfirm,
                              errorText: confirmError,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.01),
                      Padding(
                        padding: EdgeInsets.only(bottom: h * 0.02),
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            bool hasErrors = emailError != null ||
                                passError != null ||
                                confirmError != null;
                            bool isFormEmpty = name.text.isEmpty ||
                                email.text.isEmpty ||
                                password.text.isEmpty ||
                                confirm.text.isEmpty;

                            return AppButton(
                              text: state.loading ? "LOADING..." : "REGISTER",
                              onPressed: (state.loading || hasErrors || isFormEmpty)
                                  ? null
                                  : () {
                                      context.read<AuthCubit>().register(
                                            userName: name.text.trim(),
                                            email: email.text.trim(),
                                            password: password.text,
                                            confirmPassword: confirm.text,
                                          );
                                    },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}