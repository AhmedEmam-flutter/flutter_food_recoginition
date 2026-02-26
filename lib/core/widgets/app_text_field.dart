import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/utiles/color_manager.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? errorText; 
  final Function(String)? onChanged; 

  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: ColorManager.lightGrey.withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
            border: hasError ? Border.all(color: Colors.red, width: 1.5) : null,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: const TextStyle(color: ColorManager.textColor),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: TextStyle(color: ColorManager.lightGrey),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 2),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}