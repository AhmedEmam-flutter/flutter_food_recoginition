// lib/features/home/screens/foods_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/home/screens/food_detail_screen.dart';

import '../../../core/function/animated_widgets.dart';
import '../../../core/function/page_transitions.dart';

class FoodsScreen extends StatelessWidget {
  const FoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // AppBar مع السيرش بار
            SliverAppBar(
              backgroundColor: const Color(0xFFF8F9FA),
              elevation: 0,
              scrolledUnderElevation: 0,
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: 0, // إزالة المساحة الممتدة
              collapsedHeight: 60, // ارتفاع AppBar
              toolbarHeight: 60,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: _buildSearchBar(), // السيرش بار في الـ title
              centerTitle: false,
              automaticallyImplyLeading: true,
            ),

            // Recent Foods Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildRecentFoods(context),
              ),
            ),

            // Smart Food Suggestions Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: _buildSmartSuggestions(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search here',
          hintStyle: const TextStyle(color: Color(0xFF999999)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF999999)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
      ),
    );
  }

  Widget _buildRecentFoods(BuildContext context) {
    final recentFoods = [
      {
        'name': 'Apple',
        'weight': '800 gr',
        'calories': '83 cal',
        'color': const Color(0xFFFF6B6B),
        'imagePath': 'assets/pictures/apple.png',
      },
      {
        'name': 'Pizza',
        'weight': '1100 gr',
        'calories': '350 cal',
        'color': const Color(0xFFFFD166),
        'imagePath': 'assets/pictures/pizza.png',
      },
      {
        'name': 'Burger',
        'weight': '1300 gr',
        'calories': '200 cal',
        'color': const Color(0xFF4ECDC4),
        'imagePath': 'assets/pictures/burger.png',
      },
      {
        'name': 'Salad',
        'weight': '1000 gr',
        'calories': '100 cal',
        'color': const Color(0xFF42E87F),
        'imagePath': 'assets/pictures/salad.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          "Recent Foods",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: recentFoods.asMap().entries.map((entry) {
            final index = entry.key;
            final food = entry.value;
            return AnimatedListItem(
              index: index,
              child: _buildFoodCard(
                context,
                name: food['name'] as String,
                weight: food['weight'] as String,
                calories: food['calories'] as String,
                color: food['color'] as Color,
                imagePath: food['imagePath'] as String,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSmartSuggestions(BuildContext context) {
    final suggestions = [
      {
        'name': 'Rice',
        'weight': '2200 gr',
        'calories': '80 cal',
        'color': const Color(0xFF9D4EDD),
        'imagePath': 'assets/pictures/rice.png',
      },
      {
        'name': 'Chicken',
        'weight': '1100 gr',
        'calories': '390 cal',
        'color': const Color(0xFF4ECDC4),
        'imagePath': 'assets/pictures/chicken.png',
      },
      {
        'name': 'Pasta',
        'weight': '1200 gr',
        'calories': '200 cal',
        'color': const Color(0xFFFFD166),
        'imagePath': 'assets/pictures/pasta.png',
      },
      {
        'name': 'Peanut Butter',
        'weight': '1500 gr',
        'calories': '100 cal',
        'color': const Color(0xFFF8961E),
        'imagePath': 'assets/pictures/peanut_butter.png',
      },
      {
        'name': 'Lasagna',
        'weight': '500 gr',
        'calories': '100 cal',
        'color': const Color(0xFFFF6B6B),
        'imagePath': 'assets/pictures/lasagna.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          "Smart Food Suggestions",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: suggestions.asMap().entries.map((entry) {
            final index = entry.key;
            final food = entry.value;
            return AnimatedListItem(
              index: index + 4,
              child: _buildFoodCard(
                context,
                name: food['name'] as String,
                weight: food['weight'] as String,
                calories: food['calories'] as String,
                color: food['color'] as Color,
                imagePath: food['imagePath'] as String,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFoodCard(
    BuildContext context, {
    required String name,
    required String weight,
    required String calories,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                  name: _getFoodData(name)['name'],
                  time: 'Recent',
                  calories: _getFoodData(name)['calories'],
                  color: _getFoodData(name)['color'],
                  imagePath: _getFoodData(name)['imagePath'],
                  description: _getFoodData(name)['description'],
                  nutrition: _getFoodData(name)['nutrition'],
                ),
                routeType: RouteType.scale,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                          weight,
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

  Map<String, dynamic> _getFoodData(String foodName) {
    switch (foodName.toLowerCase()) {
      case 'apple':
        return {
          'name': 'Apple',
          'time': 'Recent',
          'calories': '83 cal',
          'color': const Color(0xFFFF6B6B),
          'imagePath': 'assets/pictures/apple.png',
          'description':
              'An apple is a popular, healthy, low-calorie fruit, rich in fiber and essential vitamins like Vitamin C.',
          'nutrition': {
            'calories': '83 kcal',
            'protein': '0.4g',
            'carbs': '22g',
            'fat': '0.2g',
            'fiber': '4g',
            'sugar': '17g',
          },
        };
      case 'pizza':
        return {
          'name': 'Pizza',
          'time': 'Recent',
          'calories': '350 cal',
          'color': const Color(0xFFFFD166),
          'imagePath': 'assets/pictures/pizza.png',
          'description':
              'Pizza is a popular dish of Italian origin consisting of a flat, round base of dough baked with various toppings.',
          'nutrition': {
            'calories': '350 kcal',
            'protein': '15g',
            'carbs': '40g',
            'fat': '14g',
            'fiber': '3g',
            'sugar': '5g',
          },
        };
      case 'burger':
        return {
          'name': 'Burger',
          'time': 'Recent',
          'calories': '200 cal',
          'color': const Color(0xFF4ECDC4),
          'imagePath': 'assets/pictures/burger.png',
          'description':
              'A hamburger is a sandwich consisting of one or more cooked patties of ground meat, usually beef.',
          'nutrition': {
            'calories': '200 kcal',
            'protein': '14g',
            'carbs': '20g',
            'fat': '10g',
            'fiber': '2g',
            'sugar': '4g',
          },
        };
      case 'salad':
        return {
          'name': 'Salad',
          'time': 'Recent',
          'calories': '100 cal',
          'color': const Color(0xFF42E87F),
          'imagePath': 'assets/pictures/salad.png',
          'description':
              'A salad is a dish consisting of mixed, mostly natural ingredients with at least one raw ingredient.',
          'nutrition': {
            'calories': '100 kcal',
            'protein': '3g',
            'carbs': '10g',
            'fat': '6g',
            'fiber': '4g',
            'sugar': '5g',
          },
        };
      case 'rice':
        return {
          'name': 'Rice',
          'time': 'Recent',
          'calories': '80 cal',
          'color': const Color(0xFF9D4EDD),
          'imagePath': 'assets/pictures/rice.png',
          'description':
              'Rice is the most widely consumed staple food for a large part of the world\'s human population.',
          'nutrition': {
            'calories': '80 kcal',
            'protein': '2g',
            'carbs': '18g',
            'fat': '0.5g',
            'fiber': '0.6g',
            'sugar': '0g',
          },
        };
      case 'chicken':
        return {
          'name': 'Chicken',
          'time': 'Recent',
          'calories': '390 cal',
          'color': const Color(0xFF4ECDC4),
          'imagePath': 'assets/pictures/chicken.png',
          'description':
              'Chicken is a type of poultry, and is one of the most common types of meat in the world.',
          'nutrition': {
            'calories': '390 kcal',
            'protein': '35g',
            'carbs': '0g',
            'fat': '25g',
            'fiber': '0g',
            'sugar': '0g',
          },
        };
      case 'pasta':
        return {
          'name': 'Pasta',
          'time': 'Recent',
          'calories': '200 cal',
          'color': const Color(0xFFFFD166),
          'imagePath': 'assets/pictures/pasta.png',
          'description':
              'Pasta is a type of food typically made from an unleavened dough of wheat flour mixed with water or eggs.',
          'nutrition': {
            'calories': '200 kcal',
            'protein': '7g',
            'carbs': '35g',
            'fat': '2g',
            'fiber': '3g',
            'sugar': '2g',
          },
        };
      case 'peanut butter':
        return {
          'name': 'Peanut Butter',
          'time': 'Recent',
          'calories': '100 cal',
          'color': const Color(0xFFF8961E),
          'imagePath': 'assets/pictures/peanut_butter.png',
          'description':
              'Peanut butter is a food paste or spread made from ground, dry-roasted peanuts. It is rich in protein and healthy fats.',
          'nutrition': {
            'calories': '100 kcal',
            'protein': '4g',
            'carbs': '3g',
            'fat': '8g',
            'fiber': '1g',
            'sugar': '1g',
          },
        };
      case 'lasagna':
        return {
          'name': 'Lasagna',
          'time': 'Recent',
          'calories': '100 cal',
          'color': const Color(0xFFFF6B6B),
          'imagePath': 'assets/pictures/lasagna.png',
          'description':
              'Lasagna is a type of wide, flat pasta, possibly one of the oldest types of pasta.',
          'nutrition': {
            'calories': '100 kcal',
            'protein': '6g',
            'carbs': '12g',
            'fat': '4g',
            'fiber': '2g',
            'sugar': '3g',
          },
        };
      default:
        return {
          'name': foodName,
          'time': 'Recent',
          'calories': '100 cal',
          'color': const Color(0xFF42E87F),
          'imagePath': 'assets/pictures/apple.png',
          'description': 'Detailed information about $foodName.',
          'nutrition': {
            'calories': '100 kcal',
            'protein': '5g',
            'carbs': '15g',
            'fat': '3g',
            'fiber': '2g',
            'sugar': '5g',
          },
        };
    }
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
    if (name.contains('rice')) return Icons.rice_bowl;
    return Icons.fastfood;
  }
}
