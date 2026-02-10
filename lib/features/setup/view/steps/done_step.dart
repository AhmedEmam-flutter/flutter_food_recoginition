import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/auth/presention/login_page.dart';

import '../../../../core/utiles/color_manager.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/step_scaffold.dart';

class DoneStep extends StatelessWidget {
  const DoneStep({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    final circleSize = (math.min(w, h) * 0.35).clamp(140.0, 220.0);
    final iconSize = (circleSize * 0.55).clamp(70.0, 130.0);

    return StepScaffold(
      title: "All Set!",
      subtitle: "Your health plan is ready",
      child: Center(
        child: Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(Icons.check, size: iconSize, color: Colors.white),
        ),
      ),
      bottom: AppButton(
        text: "GET STARTED",
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) =>  LoginPage()),
          );
        },
      ),
    );
  }
}
