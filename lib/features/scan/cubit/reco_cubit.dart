import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_recoginition/features/scan/api/food_recognition_api.dart';
import 'package:flutter_food_recoginition/features/scan/cubit/reco_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ScanCubit extends Cubit<ScanState> {
  final ImagePicker _picker;
  final FoodRecognitionApi _api;

  ScanCubit({
    ImagePicker? picker,
    FoodRecognitionApi? api,
  })  : _picker = picker ?? ImagePicker(),
        _api = api ?? FoodRecognitionApi(),
        super(ScanState.initial());

  void clearEffect() => emit(state.copyWith(clearEffect: true));
  Future<void> clearImage() async => emit(ScanState.initial());

  Future<void> takePhoto() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      try {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 1200,
          maxHeight: 1200,
          imageQuality: 85,
        );
        if (image == null) return;

        emit(state.copyWith(
          image: File(image.path),
          effect: const ScanSnackEffect('Photo captured successfully!', true),
          clearResult: true,
          clearError: true,
        ));
        return;
      } catch (e) {
        emit(state.copyWith(effect: ScanSnackEffect('Failed to capture photo: $e', false)));
        return;
      }
    }

    if (status.isPermanentlyDenied) {
      emit(state.copyWith(
        effect: const ScanPermissionEffect(
          title: 'Camera Access Denied',
          message: 'Please enable camera access in Settings to take photos.',
          permission: Permission.camera,
        ),
      ));
      return;
    }

    emit(state.copyWith(effect: const ScanSnackEffect('Camera permission is required to take photos.', false)));
  }

  Future<void> pickFromGallery() async {
    PermissionStatus status;
    if (Platform.isIOS) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      try {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1200,
          maxHeight: 1200,
          imageQuality: 85,
        );
        if (image == null) return;

        emit(state.copyWith(
          image: File(image.path),
          effect: const ScanSnackEffect('Image selected from gallery!', true),
          clearResult: true,
          clearError: true,
        ));
        return;
      } catch (e) {
        emit(state.copyWith(effect: ScanSnackEffect('Failed to select image: $e', false)));
        return;
      }
    }

    final permission = Platform.isIOS ? Permission.photos : Permission.storage;

    if (status.isPermanentlyDenied) {
      emit(state.copyWith(
        effect: ScanPermissionEffect(
          title: 'Gallery Access Denied',
          message: 'Please enable gallery access in Settings to select images.',
          permission: permission,
        ),
      ));
      return;
    }

    emit(state.copyWith(effect: const ScanSnackEffect('Gallery access permission is required.', false)));
  }

  Future<void> analyze() async {
    final img = state.image;
    if (img == null) return;

    emit(state.copyWith(isLoading: true, clearError: true, clearResult: true));
    try {
      final result = await _api.recognizeFood(img);
      emit(state.copyWith(isLoading: false, result: result));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      emit(state.copyWith(effect: ScanSnackEffect('Analyze failed: $e', false)));
    }
  }
}
