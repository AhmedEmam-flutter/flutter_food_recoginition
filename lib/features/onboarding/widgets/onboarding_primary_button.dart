import 'package:flutter/material.dart';
import '../../../../core/utiles/color_manager.dart';

class OnboardingPrimaryButton extends StatelessWidget {
  final bool isLast;
  final VoidCallback onPressed;

  const OnboardingPrimaryButton({
    super.key,
    required this.isLast,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
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
        child: Text(
          isLast ? 'GET STARTED' : 'NEXT',
          style: TextStyle(
            fontSize: textScale.scale(20).clamp(18, 22),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
