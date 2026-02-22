import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_recoginition/features/scan/cubit/reco_cubit.dart';
import 'package:flutter_food_recoginition/features/scan/cubit/reco_state.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/nalysis_results_sheet.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/scan_actions.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/scan_preview.dart';
import 'package:flutter_food_recoginition/features/scan/widgets/scan_texts.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanTab extends StatelessWidget {
  const ScanTab({super.key});

  Future<void> _showPermissionDialog({
    required BuildContext context,
    required String title,
    required String message,
    required Permission permission,
  }) async {
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

  void _showSnack(BuildContext context, String message,
      {required bool success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: Duration(seconds: success ? 2 : 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScanCubit(),
      child: BlocConsumer<ScanCubit, ScanState>(
        listenWhen: (prev, curr) =>
            prev.effect != curr.effect ||
            (prev.result == null && curr.result != null),
        listener: (context, state) async {
          final cubit = context.read<ScanCubit>();

          // ✅ Permission / Snack effects
          final effect = state.effect;
          if (effect is ScanPermissionEffect) {
            await _showPermissionDialog(
              context: context,
              title: effect.title,
              message: effect.message,
              permission: effect.permission,
            );
            cubit.clearEffect();
          } else if (effect is ScanSnackEffect) {
            _showSnack(context, effect.message, success: effect.success);
            cubit.clearEffect();
          }

          if (state.result != null) {
            if (!context.mounted) return;
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (_) => AnalysisResultsSheet(
                result: state.result!,
                onDone: () {
                  Navigator.pop(context);
                  cubit.clearImage();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;

              final padding = (w * 0.04).clamp(14.0, 20.0);
              final previewSize = (w * 0.55).clamp(150.0, 220.0);

              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Stack(
                      children: [
                        // ✅ Your original content (unchanged)
                        SingleChildScrollView(
                          padding: EdgeInsets.all(padding),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: h - padding * 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ScanPreview(
                                  image: state.image,
                                  size: previewSize,
                                  onClear: () =>
                                      context.read<ScanCubit>().clearImage(),
                                ),
                                SizedBox(height: (h * 0.05).clamp(20.0, 40.0)),
                                ScanTexts(
                                  hasImage: state.image != null,
                                  width: w,
                                ),
                                SizedBox(height: (h * 0.07).clamp(26.0, 60.0)),
                                ScanActions(
                                  isLoading: state.isLoading,
                                  hasImage: state.image != null,
                                  onTakePhoto: () =>
                                      context.read<ScanCubit>().takePhoto(),
                                  onPickGallery: () => context
                                      .read<ScanCubit>()
                                      .pickFromGallery(),
                                  onAnalyze: () =>
                                      context.read<ScanCubit>().analyze(),
                                  onChooseDifferent: () =>
                                      context.read<ScanCubit>().clearImage(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ✅ Back Arrow Overlay (Professional)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(w * 0.045),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(w * 0.045),
                              onTap: () => Navigator.maybePop(context),
                              child: Container(
                                width: w * 0.11,
                                height: w * 0.11,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.92),
                                  borderRadius:
                                      BorderRadius.circular(w * 0.045),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.06),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: (w * 0.048).clamp(18.0, 24.0),
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
