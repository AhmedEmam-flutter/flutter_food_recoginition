import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/scan/contoller/scan_controller.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/nalysis_results_sheet.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/scan_actions.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/scan_preview.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/scan_texts.dart';
import 'package:permission_handler/permission_handler.dart';


class ScanTab extends StatefulWidget {
  const ScanTab({super.key});

  @override
  State<ScanTab> createState() => _ScanTabState();
}

class _ScanTabState extends State<ScanTab> {
  late final ScanController controller;

  @override
  void initState() {
    super.initState();
    controller = ScanController()..addListener(_onChanged);
  }

  void _onChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    controller.dispose();
    super.dispose();
  }

  Future<void> _showPermissionDialog({
    required String title,
    required String message,
    required Permission permission,
  }) async {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showSnack(String message, {required bool success}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: Duration(seconds: success ? 2 : 3),
      ),
    );
  }

  Future<void> _handlePickResult(dynamic result) async {
    if (!mounted) return;

    if (result == null) return;

    if (result.permissionDialog == true) {
      await _showPermissionDialog(
        title: result.title ?? 'Permission Required',
        message: result.message ?? '',
        permission: result.permission!,
      );
      return;
    }

    if (result.ok == true && (result.message?.isNotEmpty ?? false)) {
      _showSnack(result.message!, success: true);
      return;
    }

    if (result.cancelled == true) return;

    if ((result.message?.isNotEmpty ?? false)) {
      _showSnack(result.message!, success: false);
    }
  }

  Future<void> _takePhoto() async {
    final r = await controller.takePhoto();
    await _handlePickResult(r);
  }

  Future<void> _pickGallery() async {
    final r = await controller.pickFromGallery();
    await _handlePickResult(r);
  }

  Future<void> _analyze() async {
    await controller.analyze();
    if (!mounted) return;

    if (controller.selectedImage == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => AnalysisResultsSheet(
        onDone: () {
          Navigator.pop(context);
          controller.clearImage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        final padding = (w * 0.04).clamp(14.0, 20.0);
        final previewSize =
            (w * 0.55).clamp(150.0, 220.0);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: h - padding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScanPreview(
                      image: controller.selectedImage,
                      size: previewSize,
                      onClear: controller.clearImage,
                    ),
                    SizedBox(height: (h * 0.05).clamp(20.0, 40.0)),
                    ScanTexts(
                      hasImage: controller.selectedImage != null,
                      width: w,
                    ),
                    SizedBox(height: (h * 0.07).clamp(26.0, 60.0)),
                    ScanActions(
                      isLoading: controller.isLoading,
                      hasImage: controller.selectedImage != null,
                      onTakePhoto: _takePhoto,
                      onPickGallery: _pickGallery,
                      onAnalyze: _analyze,
                      onChooseDifferent: controller.clearImage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
