import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';

class ProfileGoalCard extends StatelessWidget {
  final model;
  const ProfileGoalCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: w * 0.04,
            offset: Offset(0, h * 0.007),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: (h * 0.014).clamp(8.0, 12.0),
        ),
        decoration: BoxDecoration(
          color: ColorManager.primaryColor.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(w * 0.035),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.goalTitle,
              style: TextStyle(
                fontSize: (w * 0.04).clamp(14.0, 18.0),
                fontWeight: FontWeight.w900,
                color: ColorManager.textColor,
              ),
            ),
            SizedBox(height: h * 0.006),
            Text(
              model.goalSubtitle,
              style: TextStyle(
                fontSize: (w * 0.03).clamp(10.0, 13.0),
                color: ColorManager.lightGrey.withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
