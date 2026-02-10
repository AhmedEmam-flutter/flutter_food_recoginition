import 'package:flutter/material.dart';

class TodayProgressUiModel {
  final int calories;
  final int goal;
  final int protein;
  final int carbs;
  final int fat;
  final String dateLabel;

  const TodayProgressUiModel({
    required this.calories,
    required this.goal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.dateLabel,
  });
}

class RecentFoodUiModel {
  final String name;
  final String time;
  final int calories;
  final String? imageAsset; // optional (demo)

  const RecentFoodUiModel({
    required this.name,
    required this.time,
    required this.calories,
    this.imageAsset,
  });
}

class HomeViewModel extends ChangeNotifier {
  bool isLoading = true;
  String? error;

  TodayProgressUiModel? progress;
  List<RecentFoodUiModel> recentFoods = [];

  int selectedTab = 0;

  Future<void> init() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      
      await Future.delayed(const Duration(milliseconds: 400));

      
      progress = const TodayProgressUiModel(
        calories: 1547,
        goal: 2000,
        protein: 65,
        carbs: 120,
        fat: 45,
        dateLabel: "Sunday, Aug 24",
      );

      recentFoods = const [
        RecentFoodUiModel(
          name: "Apple",
          time: "9:30 pm",
          calories: 80,
          imageAsset: "assets/pictures/pizza.png", // لو مش موجودة هيتعمل fallback
        ),
        RecentFoodUiModel(
          name: "Pizza",
          time: "11:00 pm",
          calories: 380,
          imageAsset: "assets/pictures/apple.png",
        ),
      ];
    } catch (e) {
      error = "Something went wrong";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
}
