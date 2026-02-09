import 'package:flutter/material.dart';
import '../../../../core/utiles/color_manager.dart';

class OnboardingIndicators extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OnboardingIndicators({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentPage == index
                ? ColorManager.primaryColor
                : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
