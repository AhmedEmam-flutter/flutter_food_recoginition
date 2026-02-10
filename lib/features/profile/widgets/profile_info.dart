import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileBasicInfoGrid extends StatelessWidget {
  final ProfileUiModel model;
  const ProfileBasicInfoGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    final radius = w * 0.04;
    final gap = w * 0.025;
    final pad = w * 0.03;

    return Container(
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: w * 0.04,
            offset: Offset(0, h * 0.007),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _InfoTile(value: "${model.age}", unit: "years old")),
              SizedBox(width: gap),
              Expanded(child: _InfoTile(value: "${model.heightCm}", unit: "cm tall")),
            ],
          ),
          SizedBox(height: gap),
          Row(
            children: [
              Expanded(child: _InfoTile(value: model.weightKg.toStringAsFixed(0), unit: "kg weight")),
              SizedBox(width: gap),
              Expanded(child: _InfoTile(value: model.bmi.toStringAsFixed(1), unit: "BMI")),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String value;
  final String unit;
  const _InfoTile({required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    return Container(
      padding: EdgeInsets.symmetric(vertical: (h * 0.014).clamp(8.0, 12.0)),
      decoration: BoxDecoration(
        color: ColorManager.primaryColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(w * 0.035),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: (w * 0.05).clamp(16.0, 22.0),
              fontWeight: FontWeight.w900,
              color: ColorManager.textColor,
            ),
          ),
          SizedBox(height: h * 0.003),
          Text(
            unit,
            style: TextStyle(
              fontSize: (w * 0.03).clamp(10.0, 13.0),
              fontWeight: FontWeight.w600,
              color: ColorManager.textColor.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}
