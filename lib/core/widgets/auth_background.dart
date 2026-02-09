import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/utiles/color_manager.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: ColorManager.backgroundColor),

        Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            "assets/pictures/topright.png",
            width: 160,
          ),
        ),

        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.45,
          left: 0,
          child: Image.asset(
            "assets/pictures/bottomleft.png",
            width: 200,
          ),
        ),

        child,
      ],
    );
  }
}
