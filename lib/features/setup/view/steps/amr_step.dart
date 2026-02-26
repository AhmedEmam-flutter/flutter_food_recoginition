import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../model/setup_models.dart';
import '../../viewmodel/setup_viewmodel.dart';
import '../../../../core/utiles/color_manager.dart';
import '../../../../core/widgets/step_scaffold.dart';

class AmrStep extends StatelessWidget {
  const AmrStep({super.key});

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SetupViewModel>();

    return StepScaffold(
      title: "AMR",
      subtitle: "Choose your activity level",
      onBack: vm.step > 0 ? () => vm.back() : null,
      bottom: AppButton(
        text: "NEXT",
        onPressed: vm.canGoNext ? () => vm.next() : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          item(
            title: "Sedentary",
            selected: vm.data.activity == ActivityLevel.sedentary,
            onTap: () => vm.setActivity(ActivityLevel.sedentary),
          ),
          const SizedBox(height: 10),
          item(
            title: "Lightly Active",
            selected: vm.data.activity == ActivityLevel.lightlyActive,
            onTap: () => vm.setActivity(ActivityLevel.lightlyActive),
          ),
          const SizedBox(height: 10),
          item(
            title: "Moderately Active",
            selected: vm.data.activity == ActivityLevel.moderatelyActive,
            onTap: () => vm.setActivity(ActivityLevel.moderatelyActive),
          ),
          const SizedBox(height: 10),
          item(
            title: "Highly Active",
            selected: vm.data.activity == ActivityLevel.highlyActive,
            onTap: () => vm.setActivity(ActivityLevel.highlyActive),
          ),
        ],
      ),
    );
  }
}
