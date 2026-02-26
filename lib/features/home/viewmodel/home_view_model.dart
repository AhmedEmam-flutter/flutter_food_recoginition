import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/profile/service/profile_local_storage.dart';
import 'package:intl/intl.dart';
import '../../../core/storge/token_storage.dart';

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
  final String? imageAsset;

  const RecentFoodUiModel({
    required this.name,
    required this.time,
    required this.calories,
    this.imageAsset,
  });
}

class HomeViewModel extends ChangeNotifier {
  final TokenStorage storage;
  final ProfileLocalStorage profileStorage = ProfileLocalStorage();

  HomeViewModel({required this.storage});

  bool isLoading = true;
  String? error;

  TodayProgressUiModel? progress;
  List<RecentFoodUiModel> recentFoods = [];

  int selectedTab = 0;

  String userName = "";

  Future<void> init() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

  
      userName = (await storage.getUserName()) ?? "";

      final profileData = await profileStorage.loadAll();
      
      int savedGoal = 3000;
      if (profileData != null && profileData['setup'] != null) {
        savedGoal = (profileData['setup']['dailyCaloriesTarget'] as num).round();
      }

      final String todayDate = DateFormat('EEEE, MMM d').format(DateTime.now());

     
      progress = TodayProgressUiModel(
        calories: 2000,
        goal: savedGoal,
        protein: 0,
        carbs: 0,
        fat: 0,
        dateLabel: todayDate,
      );

      recentFoods = const [
        RecentFoodUiModel(
          name: "Apple",
          time: "9:30 pm",
          calories: 80,
          imageAsset: "assets/pictures/pizza.png",
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
