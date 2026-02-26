import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/utiles/color_manager.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; 

  const AppButton({
    super.key,
    required this.text,
    this.onPressed, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primaryColor,
          disabledBackgroundColor: ColorManager.lightGrey.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed, 
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}