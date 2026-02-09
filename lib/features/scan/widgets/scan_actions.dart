import 'package:flutter/material.dart';
import '../../../../core/utiles/color_manager.dart';

class ScanActions extends StatelessWidget {
  final bool isLoading;
  final bool hasImage;
  final VoidCallback onTakePhoto;
  final VoidCallback onPickGallery;
  final VoidCallback onAnalyze;
  final VoidCallback onChooseDifferent;

  const ScanActions({
    super.key,
    required this.isLoading,
    required this.hasImage,
    required this.onTakePhoto,
    required this.onPickGallery,
    required this.onAnalyze,
    required this.onChooseDifferent,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator(color: Color(0xFF42E87F));
    }

    if (hasImage) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onAnalyze,
              icon: const Icon(Icons.analytics_outlined, size: 24),
              label: const Text(
                'Analyze Food',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42E87F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
                elevation: 3,
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextButton(
            onPressed: onChooseDifferent,
            child: const Text(
              'Choose Different Image',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onTakePhoto,
            icon: const Icon(Icons.camera_alt, size: 24),
            label: const Text(
              'Take Photo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF42E87F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33),
              ),
              elevation: 3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.grey.shade300, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: Colors.grey.shade300, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onPickGallery,
            icon: const Icon(Icons.photo_library_outlined, size: 24),
            label: const Text(
              'Upload from Gallery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: ColorManager.DarkColor, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33),
              ),
              foregroundColor: ColorManager.DarkColor,
            ),
          ),
        ),
      ],
    );
  }
}
