import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/profile/service/profile_api_service.dart';
import 'package:flutter_food_recoginition/features/profile/service/profile_local_storage.dart';
import 'package:flutter_food_recoginition/features/profile/viewmodel/profile_api_models.dart';
import '../model/setup_models.dart';

class SetupViewModel extends ChangeNotifier {
  final data = SetupData();

  final pageController = PageController();
  int step = 0;

  final ProfileApiService _api = ProfileApiService();
  final ProfileLocalStorage _local = ProfileLocalStorage();

  bool isLoading = false;
  String? error;

  void setGender(Gender v) { data.gender = v; notifyListeners(); }
  void setAge(String v) { data.age = int.tryParse(v); notifyListeners(); }
  void setHeight(String v) { data.height = double.tryParse(v); notifyListeners(); }
  void setWeight(String v) { data.weight = double.tryParse(v); notifyListeners(); }
  void setActivity(ActivityLevel v) { data.activity = v; notifyListeners(); }
  void setGoal(WeightGoal v) { data.goal = v; notifyListeners(); }

  bool get canGoNext {
    switch (step) {
      case 0: return data.gender != null;
      case 1: return (data.age ?? 0) > 5;
      case 2: return (data.height ?? 0) > 50;
      case 3: return (data.weight ?? 0) > 10;
      case 4: return data.activity != null;
      case 5: return data.goal != null;
      default: return true;
    }
  }

  Future<void> next() async {
    if (!canGoNext || isLoading) return;

    error = null;

    if (step == 5) {
      await _callSetupApiAndSaveAll();
      if (error != null) return;
    }

    step++;
    await pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  Future<void> _callSetupApiAndSaveAll() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final req = ProfileSetupRequest(
        age: data.age!,
        weight: data.weight!,
        height: data.height!.round(),
        gender: data.gender!,
        activityLevel: data.activity!,
        goalType: data.goal!,
      );

      final res = await _api.setup(req); 

      
      data.maintenanceCalories = res.amr.round();
      data.goalCalories = res.dailyCaloriesTarget.round();
      data.dailyTarget = res.dailyCaloriesTarget.round();

      await _local.saveAll(
        input: {
          "age": req.age,
          "weight": req.weight,
          "height": req.height,
          "gender": req.gender.toApi(),
          "activityLevel": req.activityLevel.toApi(),
          "goalType": req.goalType.toApi(),
        },
        setup: {
          "amr": res.amr,
          "bmr": res.bmr,
          "dailyCaloriesTarget": res.dailyCaloriesTarget,
        },
      );
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
