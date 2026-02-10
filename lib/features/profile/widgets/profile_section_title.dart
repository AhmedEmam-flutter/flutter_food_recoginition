import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';

class ProfileSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileSectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Icon(icon, size: (w * 0.045).clamp(16.0, 20.0), color: ColorManager.lightGrey),
        SizedBox(width: w * 0.02),
        Text(
          title,
          style: TextStyle(
            fontSize: (w * 0.038).clamp(13.0, 16.0),
            fontWeight: FontWeight.w800,
            color: ColorManager.textColor,
          ),
        ),
      ],
    );
  }
}
