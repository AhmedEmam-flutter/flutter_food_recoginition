import 'package:flutter/material.dart';
import '../../../../core/utiles/color_manager.dart';

class OnboardingTopBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onBack;
  final VoidCallback onSkip;

  const OnboardingTopBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onBack,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final canBack = currentPage > 0;
    final canSkip = currentPage < totalPages - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          canBack
              ? IconButton(
                  onPressed: onBack,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: ColorManager.primaryColor,
                  ),
                )
              : const SizedBox(width: 48),
          canSkip
              ? InkWell(
                  onTap: onSkip,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
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
    );
  }
}
