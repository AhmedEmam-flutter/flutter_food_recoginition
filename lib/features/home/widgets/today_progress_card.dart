import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';
import '../viewmodel/home_view_model.dart';

class TodayProgressCard extends StatelessWidget {
  final TodayProgressUiModel progress;

  const TodayProgressCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final radius = w * 0.04;
    final pad = w * 0.035;
    final gap = h * 0.012;

    final titleFs = (w * 0.04).clamp(13.0, 16.0);
    final smallFs = (w * 0.032).clamp(10.0, 13.0);
    final valueFs = (w * 0.034).clamp(11.0, 14.0);

    final ratio = (progress.goal == 0)
        ? 0.0
        : (progress.calories / progress.goal).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: w * 0.04,
            offset: Offset(0, h * 0.007),
          ),
        ],
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today’s Progress",
                style: TextStyle(
                  fontSize: titleFs,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
              ),
              Text(
                progress.dateLabel,
                style: TextStyle(
                  fontSize: smallFs,
                  color: ColorManager.lightGrey.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),
          SizedBox(height: gap),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Calories",
                style: TextStyle(
                  fontSize: smallFs,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.lightGrey,
                ),
              ),
              Text(
                "${progress.calories}/${progress.goal}",
                style: TextStyle(
                  fontSize: valueFs,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.01),

          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: (h * 0.014).clamp(8.0, 12.0),
              backgroundColor: Colors.black.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation(ColorManager.primaryColor),
            ),
          ),

          SizedBox(height: h * 0.016),

          Row(
            children: [
              _Macro(label: "Protein", value: "${progress.protein}g"),
              SizedBox(width: w * 0.02),
              _Macro(label: "Carbs", value: "${progress.carbs}g"),
              SizedBox(width: w * 0.02),
              _Macro(label: "Fat", value: "${progress.fat}g"),
            ],
          ),
        ],
      ),
    );
  }
}

class _Macro extends StatelessWidget {
  final String label;
  final String value;

  const _Macro({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final radius = w * 0.035;
    final valueFs = (w * 0.036).clamp(12.0, 16.0);
    final labelFs = (w * 0.03).clamp(10.0, 12.0);

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: (h * 0.014).clamp(8.0, 12.0)),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: valueFs,
                fontWeight: FontWeight.w800,
                color: ColorManager.textColor,
              ),
            ),
            SizedBox(height: h * 0.003),
            Text(
              label,
              style: TextStyle(
                fontSize: labelFs,
                color: ColorManager.lightGrey.withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
