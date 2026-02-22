import 'package:flutter/material.dart';

class PromptHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.green.withOpacity(.08),
      child: const Text(
        "How to ask:\n"
        "• Chicken shawarma low calories\n"
        "• Recipe for rice and chicken\n"
        "• 200g tuna calories",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
