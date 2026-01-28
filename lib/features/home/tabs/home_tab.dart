// lib/features/home/tabs/home_tab.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/utiles/color_manager.dart';
import 'package:flutter_food_recoginition/features/home/screens/food_detail_screen.dart';
import 'package:flutter_food_recoginition/features/home/screens/foods_screen.dart';

import '../../../core/function/animated_widgets.dart';
import '../../../core/function/page_transitions.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(),
              const SizedBox(height: 32),

              // Today's Progress Card
              ScaleAnimation(
                child: _buildProgressCard(),
              ),
              const SizedBox(height: 32),

              // Quick Actions
              _buildQuickActions(),
              const SizedBox(height: 32),

              // Recent Foods
              _buildRecentFoods(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInAnimation(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$greeting ',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Ahmed! ',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF42E87F),
                            ),
                          ),
                          const TextSpan(
                            text: '👋',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FadeInAnimation(
                    duration: const Duration(milliseconds: 600),
                    child: const Text(
                      "Let's track your nutrition today",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ScaleAnimation(
              child: CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF42E87F).withOpacity(0.2),
                child: const Icon(
                  Icons.person,
                  size: 32,
                  color: Color(0xFF42E87F),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
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
            "Today's Progress",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          // Calories Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Calories",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "1547/2000",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Sunday, Aug 24",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 80,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.77,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF42E87F),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Nutrition Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildNutritionItem(
                label: "Protein",
                value: "65g",
                color: const Color(0xFF4ECDC4),
              ),
              _buildNutritionItem(
                label: "Carbs",
                value: "120g",
                color: const Color(0xFFFFD166),
              ),
              _buildNutritionItem(
                label: "Fat",
                value: "45g",
                color: const Color(0xFFFF6B6B),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return BounceAnimation(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {
        'icon': Icons.camera_alt_outlined,
        'label': 'Scan Your Food',
        'color': ColorManager.primaryColor,
      },
      {
        'icon': Icons.auto_awesome,
        'label': 'Ask AI',
        'color': const Color(0xFF4ECDC4),
      },
      {
        'icon': Icons.bar_chart,
        'label': 'View Stats',
        'color': const Color(0xFFFFD166),
      },
      {
        'icon': Icons.add_circle,
        'label': 'Add Manually',
        'color': const Color(0xFFFF6B6B),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.2,
          children: actions.map((action) {
            return ScaleAnimation(
              child: _buildActionButton(
                icon: action['icon'] as IconData,
                label: action['label'] as String,
                color: action['color'] as Color,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ScaleAnimation(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FadeInAnimation(
                    offsetX: 10,
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentFoods(BuildContext context) {
    final recentFoods = [
      {
        'name': 'Apple',
        'time': '8:30 pm',
        'calories': '95 kcal',
        'color': const Color(0xFFFF6B6B),
        'imagePath': 'assets/pictures/apple.png',
        'description':
            'An apple is a popular, healthy, low-calorie fruit, rich in fiber and essential vitamins like Vitamin C, commonly used in dietary analysis.',
        'nutrition': {
          'calories': '95 kcal',
          'protein': '0.5g',
          'carbs': '25g',
          'fat': '0.3g',
          'fiber': '4.4g',
          'sugar': '19g',
        },
      },
      {
        'name': 'Pizza',
        'time': '11:00 pm',
        'calories': '285 kcal',
        'color': const Color(0xFFFFD166),
        'imagePath': 'assets/pictures/pizza.png',
        'description':
            'Pizza is a popular dish of Italian origin consisting of a flat, round base of dough baked with various toppings.',
        'nutrition': {
          'calories': '285 kcal',
          'protein': '12g',
          'carbs': '36g',
          'fat': '10g',
          'fiber': '2g',
          'sugar': '3g',
        },
      },
      {
        'name': 'Burger',
        'time': '1:30 pm',
        'calories': '354 kcal',
        'color': const Color(0xFF4ECDC4),
        'imagePath': 'assets/pictures/burger.png',
        'description':
            'A hamburger is a sandwich consisting of one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll.',
        'nutrition': {
          'calories': '354 kcal',
          'protein': '25g',
          'carbs': '30g',
          'fat': '15g',
          'fiber': '3g',
          'sugar': '5g',
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Foods",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CustomPageRoute(
                    page: const FoodsScreen(),
                    routeType: RouteType.slideRight,
                  ),
                );
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF42E87F),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: recentFoods.asMap().entries.map((entry) {
            final index = entry.key;
            final food = entry.value;
            return AnimatedListItem(
              index: index,
              child: _buildFoodItem(
                context: context,
                name: food['name'] as String,
                time: food['time'] as String,
                calories: food['calories'] as String,
                color: food['color'] as Color,
                imagePath: food['imagePath'] as String,
                description: food['description'] as String,
                nutrition: food['nutrition'] as Map<String, String>,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFoodItem({
    required BuildContext context,
    required String name,
    required String time,
    required String calories,
    required Color color,
    required String imagePath,
    required String description,
    required Map<String, String> nutrition,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              CustomPageRoute(
                page: FoodDetailScreen(
                  name: name,
                  time: time,
                  calories: calories,
                  color: color,
                  imagePath: imagePath,
                  description: description,
                  nutrition: nutrition,
                ),
                routeType: RouteType.custom,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                // Food Image
                ScaleAnimation(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
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
                                size: 28,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      FadeInAnimation(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BounceAnimation(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        calories,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getFoodIcon(String foodName) {
    final name = foodName.toLowerCase();
    if (name.contains('apple')) return Icons.apple;
    if (name.contains('pizza')) return Icons.local_pizza;
    if (name.contains('burger')) return Icons.lunch_dining;
    return Icons.fastfood;
  }
}
