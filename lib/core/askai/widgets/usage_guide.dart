import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';

class UsageGuideWidget extends StatelessWidget {
  const UsageGuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorManager.primaryColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "💡 How to use magic prompts:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          _guideRow("🍳 'How to make healthy pancakes?'"),
          _guideRow("📊 'Estimate calories in 200g of Rice'"),
        ],
      ),
    );
  }

  Widget _guideRow(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          text,
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
      );
}
