import 'package:flutter/material.dart';

import 'features/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const OnBoardingScreen(),
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
      },
    );
  }
}
