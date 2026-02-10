import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/onboarding/models/onboarding_item.dart';
import '../../../../core/utiles/color_manager.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final double height;
  final double width;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final imageH = (height * 0.28).clamp(160.0, 220.0);
    final spaceAfterImage = (height * 0.12).clamp(32.0, 110.0);
    final titleSize = (width * 0.07).clamp(20.0, 30.0);
    final descSize = (width * 0.04).clamp(13.0, 16.5);
    final horizontal = (width * 0.06).clamp(16.0, 28.0);

    return SingleChildScrollView(
      child: SizedBox(
        height: height * 0.72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: imageH,
              width: double.infinity,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: (width * 0.18).clamp(56.0, 88.0),
                          color: ColorManager.primaryColor.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: (width * 0.04).clamp(14.0, 16.0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: spaceAfterImage),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.primaryColor,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(height: (height * 0.04).clamp(18.0, 32.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: Text(
                item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: descSize,
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
