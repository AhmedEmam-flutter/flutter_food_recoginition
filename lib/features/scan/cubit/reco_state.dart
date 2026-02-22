import 'dart:io';
import 'package:flutter_food_recoginition/features/scan/model/food_recognition_result.dart';
import 'package:permission_handler/permission_handler.dart';


sealed class ScanEffect {
  const ScanEffect();
}

class ScanSnackEffect extends ScanEffect {
  final String message;
  final bool success;
  const ScanSnackEffect(this.message, this.success);
}

class ScanPermissionEffect extends ScanEffect {
  final String title;
  final String message;
  final Permission permission;
  const ScanPermissionEffect({
    required this.title,
    required this.message,
    required this.permission,
  });
}

class ScanState {
  final File? image;
  final bool isLoading;
  final FoodRecognitionResult? result;
  final String? errorMessage;
  final ScanEffect? effect;

  const ScanState({
    required this.image,
    required this.isLoading,
    required this.result,
    required this.errorMessage,
    required this.effect,
  });

  factory ScanState.initial() => const ScanState(
        image: null,
        isLoading: false,
        result: null,
        errorMessage: null,
        effect: null,
      );

  ScanState copyWith({
    File? image,
    bool? isLoading,
    FoodRecognitionResult? result,
    String? errorMessage,
    ScanEffect? effect,
    bool clearResult = false,
    bool clearError = false,
    bool clearEffect = false,
  }) {
    return ScanState(
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      result: clearResult ? null : (result ?? this.result),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      effect: clearEffect ? null : (effect ?? this.effect),
    );
  }
}
