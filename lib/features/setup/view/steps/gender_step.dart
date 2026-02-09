import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../model/setup_models.dart';
import '../../viewmodel/setup_viewmodel.dart';
import '../../../../core/utiles/color_manager.dart';
import '../../../../core/widgets/step_scaffold.dart';

class GenderStep extends StatelessWidget {
  const GenderStep({super.key});

  Widget pick({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: selected
              ? ColorManager.DarkColor
              : ColorManager.DarkColor.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SetupViewModel>();
    return StepScaffold(
      title: "Gender",
      subtitle: "What’s your gender?",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pick(text: "Male", selected: vm.data.gender == Gender.male, onTap: () => vm.setGender(Gender.male)),
          const SizedBox(height: 12),
          pick(text: "Female", selected: vm.data.gender == Gender.female, onTap: () => vm.setGender(Gender.female)),
        ],
      ),
      bottom: AppButton(
        text: "NEXT",
        onPressed: vm.canGoNext ? () => vm.next() : null,
      ),
    );
  }
}