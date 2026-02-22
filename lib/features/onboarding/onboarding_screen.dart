import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/auth/presention/login_page.dart';
import 'package:flutter_food_recoginition/features/onboarding/data/onboarding_data.dart';
import 'package:flutter_food_recoginition/features/onboarding/widgets/onboarding_indicators.dart';
import 'package:flutter_food_recoginition/features/onboarding/widgets/onboarding_page.dart';
import 'package:flutter_food_recoginition/features/onboarding/widgets/onboarding_primary_button.dart';
import 'package:flutter_food_recoginition/features/onboarding/widgets/onboarding_top_bar.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "/OnBoarding";
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final lastIndex = onboardingItems.length - 1;
    if (_currentPage < lastIndex) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToEnd() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                OnboardingTopBar(
                  currentPage: _currentPage,
                  totalPages: onboardingItems.length,
                  onBack: _previousPage,
                  onSkip: _skipToEnd,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingItems.length,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      return OnboardingPage(
                        item: onboardingItems[index],
                        height: h,
                        width: w,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all((w * 0.04).clamp(12.0, 18.0)),
                  child: Column(
                    children: [
                      OnboardingIndicators(
                        currentPage: _currentPage,
                        totalPages: onboardingItems.length,
                      ),
                      SizedBox(height: (h * 0.03).clamp(18.0, 30.0)),
                      OnboardingPrimaryButton(
                        isLast: _currentPage == onboardingItems.length - 1,
                        onPressed: _nextPage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
