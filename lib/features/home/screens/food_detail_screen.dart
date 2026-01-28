// lib/features/home/screens/food_detail_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../core/function/animated_widgets.dart';

class FoodDetailScreen extends StatelessWidget {
  final String name;
  final String time;
  final String calories;
  final Color color;
  final String imagePath;
  final String description;
  final Map<String, String> nutrition;

  const FoodDetailScreen({
    super.key,
    required this.name,
    required this.time,
    required this.calories,
    required this.color,
    required this.imagePath,
    required this.description,
    required this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: FadeInAnimation(
          offsetX: -20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: FadeInAnimation(
          offsetX: -10,
          child: const Text(
            'Food Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Header Card
            ScaleAnimation(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              child: _buildFoodHeaderCard(),
            ),
            const SizedBox(height: 24),

            // Description Section
            AnimatedListItem(
              index: 0,
              child: _buildDescriptionSection(),
            ),
            const SizedBox(height: 24),

            // Nutrition Facts Section
            AnimatedListItem(
              index: 1,
              delay: const Duration(milliseconds: 100),
              child: _buildNutritionFactsSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Food Image
          ScaleAnimation(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: color.withOpacity(0.1),
                      child: Center(
                        child: Icon(
                          _getFoodIcon(name),
                          color: color,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Food Name and Time
          FadeInAnimation(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          FadeInAnimation(
            duration: const Duration(milliseconds: 500),
            child: Text(
              time,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Calories
          BounceAnimation(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF42E87F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                calories,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF42E87F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionFactsSection() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nutrition Facts",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Nutrition Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildNutritionItem(
                  label: "Calories",
                  value: nutrition['calories'] ?? '0',
                  color: const Color(0xFF42E87F),
                  index: 0,
                ),
                _buildNutritionItem(
                  label: "Protein",
                  value: nutrition['protein'] ?? '0g',
                  color: const Color(0xFF4ECDC4),
                  index: 1,
                ),
                _buildNutritionItem(
                  label: "Carbs",
                  value: nutrition['carbs'] ?? '0g',
                  color: const Color(0xFFFFD166),
                  index: 2,
                ),
                _buildNutritionItem(
                  label: "Fat",
                  value: nutrition['fat'] ?? '0g',
                  color: const Color(0xFFFF6B6B),
                  index: 3,
                ),
                _buildNutritionItem(
                  label: "Fiber",
                  value: nutrition['fiber'] ?? '0g',
                  color: const Color(0xFF9D4EDD),
                  index: 4,
                ),
                _buildNutritionItem(
                  label: "Sugar",
                  value: nutrition['sugar'] ?? '0g',
                  color: const Color(0xFFF8961E),
                  index: 5,
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildNutritionItem({
    required String label,
    required String value,
    required Color color,
    required int index,
  }) {
    return AnimatedListItem(
      index: index,
      delay: Duration(milliseconds: index * 100),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BounceAnimation(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFoodIcon(String foodName) {
    final name = foodName.toLowerCase();
    if (name.contains('apple')) return Icons.apple;
    if (name.contains('pizza')) return Icons.local_pizza;
    if (name.contains('burger')) return Icons.lunch_dining;
    if (name.contains('salad')) return Icons.eco;
    if (name.contains('chicken')) return Icons.kebab_dining;
    if (name.contains('pasta')) return Icons.dinner_dining;
    if (name.contains('peanut')) return Icons.egg_alt;
    if (name.contains('lasagna')) return Icons.restaurant;
    return Icons.fastfood;
  }
}
