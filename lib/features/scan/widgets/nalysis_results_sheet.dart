import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/scan/model/food_recognition_result.dart';
import '../../../../core/utiles/color_manager.dart';

class AnalysisResultsSheet extends StatelessWidget {
  final VoidCallback onDone;
  final FoodRecognitionResult result;

  const AnalysisResultsSheet({
    super.key,
    required this.onDone,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final confidence = result.confidenceScore.clamp(0.0, 1.0);
    String pct(double v) => '${(v * 100).toStringAsFixed(0)}%';

    final titleFs = (w * 0.06).clamp(18.0, 22.0);
    final subFs = (w * 0.038).clamp(13.0, 15.0);

    return Container(
      height: h * 0.78,
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 56,
              height: 5,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 14),

          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: ColorManager.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analysis Results',
                      style: TextStyle(
                        fontSize: titleFs,
                        fontWeight: FontWeight.w800,
                        color: ColorManager.DarkColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Nutritional breakdown based on the selected image',
                      style: TextStyle(
                        fontSize: subFs,
                        color: Colors.grey.shade600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

    
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _ChipPill(
                icon: Icons.restaurant_menu,
                text: result.foodName,
              ),
              _ChipPill(
                icon: Icons.category_outlined,
                text: result.categoryName,
              ),
            ],
          ),

          const SizedBox(height: 18),

          
          Text(
            'Macros',
            style: TextStyle(
              fontSize: (w * 0.045).clamp(14.0, 16.0),
              fontWeight: FontWeight.w800,
              color: ColorManager.DarkColor,
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _MacroCard(
                  title: 'Calories',
                  value: result.calories.toStringAsFixed(0),
                  unit: 'kcal',
                  icon: Icons.local_fire_department_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MacroCard(
                  title: 'Protein',
                  value: result.protien.toStringAsFixed(1),
                  unit: 'g',
                  icon: Icons.fitness_center_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _MacroCard(
                  title: 'Carbs',
                  value: result.carbs.toStringAsFixed(1),
                  unit: 'g',
                  icon: Icons.rice_bowl_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MacroCard(
                  title: 'Fat',
                  value: result.fats.toStringAsFixed(1),
                  unit: 'g',
                  icon: Icons.opacity_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          
          Text(
            'Confidence',
            style: TextStyle(
              fontSize: (w * 0.045).clamp(14.0, 16.0),
              fontWeight: FontWeight.w800,
              color: ColorManager.DarkColor,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.grey.shade50,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: confidence,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation(ColorManager.primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  pct(confidence),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: ColorManager.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onDone,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ChipPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: ColorManager.primaryColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: ColorManager.primaryColor.withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: ColorManager.primaryColor),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: ColorManager.DarkColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MacroCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;

  const _MacroCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ColorManager.primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: ColorManager.primaryColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: ColorManager.DarkColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        unit,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
