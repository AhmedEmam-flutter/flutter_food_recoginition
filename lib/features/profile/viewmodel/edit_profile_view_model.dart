import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/profile/service/profile_api_service.dart';
import 'package:flutter_food_recoginition/features/profile/viewmodel/profile_api_models.dart';
import '../../setup/model/setup_models.dart';


class EditProfileViewModel extends ChangeNotifier {
  final ProfileApiService _api = ProfileApiService();

  final ageC = TextEditingController();
  final heightC = TextEditingController();
  final weightC = TextEditingController();

  Gender? gender;
  ActivityLevel? activity;
  WeightGoal? goal;

  bool isSaving = false;
  String? error;

  void fillDefaults({required int age, required int heightCm, required double weightKg}) {
    ageC.text = age.toString();
    heightC.text = heightCm.toString();
    weightC.text = weightKg.toStringAsFixed(1);
  }

  bool get canSave {
    final a = int.tryParse(ageC.text) ?? 0;
    final h = double.tryParse(heightC.text) ?? 0;
    final w = double.tryParse(weightC.text) ?? 0;
    return a > 5 && h > 50 && w > 10 && gender != null && activity != null && goal != null;
  }

  Future<bool> save() async {
    if (!canSave || isSaving) return false;
    try {
      isSaving = true;
      error = null;
      notifyListeners();

      final req = ProfileSetupRequest(
        age: int.parse(ageC.text),
        weight: double.parse(weightC.text),
        height: double.parse(heightC.text).round(),
        gender: gender!,
        activityLevel: activity!,
        goalType: goal!,
      );

      await _api.update(req);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    ageC.dispose();
    heightC.dispose();
    weightC.dispose();
    super.dispose();
  }
}
