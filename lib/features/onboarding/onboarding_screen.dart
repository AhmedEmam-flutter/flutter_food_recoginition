// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';

import '../../core/utiles/color_manager.dart';
import '../home/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "/OnBoarding";
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Smart Scan',
      'description':
          'Quickly analyze any meal using advanced AI food recognition technology designed to detect ingredients and estimate calories in seconds',
      'imagePath': 'assets/pictures/scanning 2.png',
    },
    {
      'title': 'Calories Estimation',
      'description':
          'Your foods are automatically evaluated with precise calorie predictions, helping you understand what you eat with clear and simple insights',
      'imagePath': 'assets/pictures/calories-calculator (2) 2.png',
    },
    {
      'title': 'Health Insight',
      'description':
          'Track daily meals and nutritional information effortlessly, giving you a smarter way to stay aware of your eating habits and reach your goals',
      'imagePath': 'assets/pictures/report (1) 1.png',
    },
  ];

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
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back and skip buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button (only shown on page 2 and 3)
                  _currentPage > 0
                      ? IconButton(
                          onPressed: _previousPage,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 24,
                            color: ColorManager.primaryColor,
                          ),
                        )
                      : const SizedBox(width: 48),

                  // Skip button (not shown on last page)
                  _currentPage < _onboardingData.length - 1
                      ? GestureDetector(
                          onTap: _skipToEnd,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'SKIP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: ColorManager.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(width: 64),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingData[index]);
                },
              ),
            ),

            // Bottom section with indicators and button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 32 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _currentPage == index
                              ? ColorManager.primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Next/Get Started button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        _currentPage == _onboardingData.length - 1
                            ? 'GET STARTED'
                            : 'NEXT',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, dynamic> data) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height *
            0.65, // تحديد ارتفاع للـ Container
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // هذا يجعل المحتوى في المنتصف رأسيًا
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image centered
            Container(
              height: 193, // ارتفاع ثابت للصورة
              width: double.infinity,
              child: Image.asset(
                data['imagePath'],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 80,
                          color: ColorManager.primaryColor.withOpacity(0.3),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data['title'],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 123),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                data['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.primaryColor,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                data['description'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
