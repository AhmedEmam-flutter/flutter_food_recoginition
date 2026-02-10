import '../../setup/model/setup_models.dart';

class ProfileSetupRequest {
  final int age;
  final double weight;
  final int height;
  final Gender gender;
  final ActivityLevel activityLevel;
  final WeightGoal goalType;

  const ProfileSetupRequest({
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.goalType,
  });

  Map<String, dynamic> toJson() => {
        "age": age,
        "weight": weight,
        "height": height,
        "gender": gender.toApi(),
        "activityLevel": activityLevel.toApi(),
        "goalType": goalType.toApi(),
      };
}

class ProfileSetupResponse {
  final double amr;
  final double bmr;
  final double dailyCaloriesTarget;

  const ProfileSetupResponse({
    required this.amr,
    required this.bmr,
    required this.dailyCaloriesTarget,
  });

  factory ProfileSetupResponse.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => (v is num) ? v.toDouble() : double.parse(v.toString());
    return ProfileSetupResponse(
      amr: d(json["amr"]),
      bmr: d(json["bmr"]),
      dailyCaloriesTarget: d(json["dailyCaloriesTarget"]),
    );
  }
}

// ✅ enum -> API strings
extension GenderApi on Gender {
  String toApi() => this == Gender.male ? "Male" : "Female";
}

extension ActivityApi on ActivityLevel {
  String toApi() {
    switch (this) {
      case ActivityLevel.sedentary:
        return "Sedentary";
      case ActivityLevel.lightlyActive:
        return "LightlyActive";
      case ActivityLevel.moderatelyActive:
        return "ModeratelyActive";
      case ActivityLevel.highlyActive:
        return "HighlyActive";
    }
  }
}

extension GoalApi on WeightGoal {
  
  String toApi() {
    switch (this) {
      case WeightGoal.weightLoss:
        return "LoseWeight";
      case WeightGoal.maintain:
        return "MaintainWeight";
      case WeightGoal.weightGain:
        return "GainWeight";
    }
  }
}
