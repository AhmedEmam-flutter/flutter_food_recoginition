import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_recoginition/core/diauth/service_locator.dart';
import 'package:flutter_food_recoginition/core/utiles/color_manager.dart';
import 'package:flutter_food_recoginition/features/auth/presention/cubit/authcubit_cubit.dart';
import 'package:flutter_food_recoginition/features/auth/presention/cubit/authcubit_state.dart';
import 'package:flutter_food_recoginition/features/auth/presention/register_page.dart';

import '../../../../core/widgets/auth_background.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  String? emailError;
  String? passError;

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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

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
                      context, '/home', (_) => false);
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
                        "Welcome back",
                        style: TextStyle(
                          color: ColorManager.primaryColor,
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: h * 0.2),
                      Text.rich(
                        TextSpan(
                          text: "Don’t have an account ? ",
                          style: TextStyle(
                            color: ColorManager.textColor,
                            fontSize: w * 0.032,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: ColorManager.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.032,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RegisterPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.03),
                      SizedBox(
                        width: w * 0.90,
                        child: Column(
                          children: [
                            AppTextField(
                              controller: email,
                              hint: "Enter your Email",
                              keyboardType: TextInputType.emailAddress,
                              onChanged: validateEmail,
                              errorText: emailError,
                            ),
                            SizedBox(height: h * 0.015),
                            AppTextField(
                              controller: password,
                              hint: "Enter Password",
                              obscure: true,
                              onChanged: validatePassword,
                              errorText: passError,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      Text(
                        "Forget password ?",
                        style: TextStyle(
                          color: ColorManager.textColor,
                          fontSize: w * 0.03,
                        ),
                      ),
                      SizedBox(height: h * 0.15),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          bool hasError = emailError != null || passError != null;
                          bool isEmpty = email.text.isEmpty || password.text.isEmpty;

                          return AppButton(
                            text: state.loading ? "LOADING..." : "LOGIN",
                            onPressed: (state.loading || hasError || isEmpty)
                                ? null
                                : () {
                                    context.read<AuthCubit>().login(
                                          email: email.text.trim(),
                                          password: password.text,
                                        );
                                  },
                          );
                        },
                      ),
                      SizedBox(height: h * 0.02),
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