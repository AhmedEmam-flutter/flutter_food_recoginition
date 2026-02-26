import 'package:flutter/material.dart';
import '../utiles/color_manager.dart';

class StepScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final Widget bottom;
  final VoidCallback? onBack;

  const StepScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.bottom,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: h * 0.1,
              right: w * 0.05,
              child: Image.asset(
                'assets/pictures/topright.png',
                width: w * 0.18,
              ),
            ),
            Positioned(
              bottom: h * 0.1,
              left: w * 0.1,
              child: Image.asset(
                'assets/pictures/bottomleft.png',
                width: w * 0.25,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.01),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      if (onBack != null) {
                        onBack!();
                      } else {
                        Navigator.maybePop(context);
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios_new, size: w * 0.045),
                  ),
                  SizedBox(height: h * 0.01),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w900,
                        color: ColorManager.textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.05),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: ColorManager.textColor,
                        fontSize: w * 0.05,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  Expanded(child: Center(child: child)),
                  bottom,
                  SizedBox(height: h * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
