import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_recoginition/core/diauth/service_locator.dart';
import 'package:flutter_food_recoginition/features/auth/presention/cubit/authcubit_cubit.dart';

import 'package:flutter_food_recoginition/features/auth/presention/login_page.dart';
import 'package:flutter_food_recoginition/features/home/view/home_page.dart';
import 'package:flutter_food_recoginition/features/profile/view/profile_page.dart';
import 'package:flutter_food_recoginition/features/setup/view/setup_flow_page.dart';
import 'package:flutter_food_recoginition/features/spalsh/splash.dart';
import 'features/onboarding/onboarding_screen.dart';


void main() {
  setupServiceLocator(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Islamic App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF202020),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF42E87F),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const SplashPage(),
        routes: {
          OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
          HomePage.routeName: (context) => const HomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          SetupFlowPage.routeName: (context) => const SetupFlowPage(),
        },
      ),
    );
  }
}
