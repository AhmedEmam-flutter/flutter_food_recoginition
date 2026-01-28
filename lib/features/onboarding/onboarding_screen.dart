// ignore_for_file: camel_case_types, deprecated_member_use, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../../core/utiles/color_manager.dart';
import '../home/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "/OnBoarding";
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _indicatorController;
  bool _isAnimationInitialized = false;

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

    // تهيئة متحكم الأنيميشن
    _indicatorController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // تهيئة الأنيميشن بعد تأكيد أن المتحكم جاهز
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _isAnimationInitialized = true;
        _indicatorController.forward();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // تأكيد تهيئة الأنيميشن عند تغيير dependencies
    if (!_isAnimationInitialized && mounted) {
      _isAnimationInitialized = true;
      _indicatorController.forward();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _indicatorController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _skipToEnd() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _restartIndicatorAnimation() {
    if (_isAnimationInitialized) {
      _indicatorController.reset();
      _indicatorController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // تحديث مؤشرات الصفحات عند التغيير
    if (_pageController.hasClients) {
      _pageController.addListener(() {
        final page = _pageController.page?.round() ?? 0;
        if (page != _currentPage && mounted) {
          setState(() {
            _currentPage = page;
          });
          _restartIndicatorAnimation();
        }
      });
    }

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
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _currentPage > 0 ? 1.0 : 0.0,
                    child: SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: _previousPage,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                    ),
                  ),

                  // Skip button with fixed size
                  SizedBox(
                    width: 100, // Fixed width to prevent overflow
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity:
                          _currentPage < _onboardingData.length - 1 ? 1.0 : 0.0,
                      child: GestureDetector(
                        onTap: _skipToEnd,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'SKIP',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.primaryColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: ColorManager.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  if (mounted) {
                    setState(() {
                      _currentPage = index;
                    });
                    _restartIndicatorAnimation();
                  }
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingData[index], index);
                },
              ),
            ),

            // Bottom section with indicators and button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // Page indicators with custom animation
                  Container(
                    height: 24,
                    child: Center(
                      child: _buildAnimatedIndicators(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Next/Get Started button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          _currentPage == _onboardingData.length - 1
                              ? 'GET STARTED'
                              : 'NEXT',
                          key: ValueKey(_currentPage),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedIndicators() {
    // إذا لم يتم تهيئة الأنيميشن بعد، استخدم مؤشرات بسيطة
    if (!_isAnimationInitialized) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _onboardingData.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: index == _currentPage
                  ? ColorManager.primaryColor
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingData.length,
        (index) {
          return GestureDetector(
            onTap: () => _goToPage(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: AnimatedBuilder(
                animation: _indicatorController,
                builder: (context, child) {
                  final isActive = index == _currentPage;
                  final double progress =
                      isActive ? _indicatorController.value : 1.0;

                  return CustomPaint(
                    size: const Size(32, 8),
                    painter: _IndicatorPainter(
                      isActive: isActive,
                      progress: progress,
                      activeColor: ColorManager.primaryColor,
                      inactiveColor: Colors.grey.shade300,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, dynamic> data, int index) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top decoration image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 47),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/pictures/topright.png',
                  height: 82,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            // Main image with smooth animation
            Container(
              key: ValueKey(data['imagePath']),
              height: 193,
              width: double.infinity,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOutBack,
                    ),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  data['imagePath'],
                  key: ValueKey(data['imagePath']),
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
            ),

            // Bottom decoration image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 47),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/pictures/bottomleft.png',
                  height: 82,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Title with fade animation
            Padding(
              key: ValueKey('title_${data['title']}'),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  key: ValueKey('title_${data['title']}'),
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
            ),

            const SizedBox(height: 32),

            // Description with fade animation
            Padding(
              key: ValueKey('desc_${data['description'].substring(0, 20)}'),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  key: ValueKey('desc_${data['description'].substring(0, 20)}'),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _IndicatorPainter extends CustomPainter {
  final bool isActive;
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  _IndicatorPainter({
    required this.isActive,
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final radius = size.height / 2;

    // Draw inactive background
    paint.color = inactiveColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ),
      paint,
    );

    // Draw active indicator with animation
    if (isActive) {
      paint.color = activeColor;

      // Animate width from small to full
      final animatedWidth = 8 + (size.width - 8) * progress;
      final centerX = size.width / 2;
      final animatedLeft = centerX - animatedWidth / 2;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(animatedLeft, 0, animatedWidth, size.height),
          Radius.circular(radius),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
