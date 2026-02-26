import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../model/setup_models.dart';
import '../../viewmodel/setup_viewmodel.dart';
import '../../../../core/utiles/color_manager.dart';
import '../../../../core/widgets/step_scaffold.dart';

class GoalStep extends StatelessWidget {
  const GoalStep({super.key});

  Widget item({
    required String title,
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
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SetupViewModel>();

    return StepScaffold(
      title: "Weight Goal",
      subtitle: "What’s your goal?",
      onBack: vm.step > 0 ? () => vm.back() : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          item(
            title: "Weight Gain",
            selected: vm.data.goal == WeightGoal.weightGain,
            onTap: () => vm.setGoal(WeightGoal.weightGain),
          ),
          const SizedBox(height: 10),
          item(
            title: "Maintain Weight",
            selected: vm.data.goal == WeightGoal.maintain,
            onTap: () => vm.setGoal(WeightGoal.maintain),
          ),
          const SizedBox(height: 10),
          item(
            title: "Weight Loss",
            selected: vm.data.goal == WeightGoal.weightLoss,
            onTap: () => vm.setGoal(WeightGoal.weightLoss),
          ),
        ],
      ),
     bottom: AppButton(
  text: "NEXT",
  onPressed: vm.canGoNext ? () => vm.next() : null,
),

    );
  }
}
