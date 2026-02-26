import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_button.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/setup_viewmodel.dart';

import '../../../../core/widgets/step_scaffold.dart';

// ...imports
class HeightStep extends StatefulWidget {
  const HeightStep({super.key});
  @override State<HeightStep> createState() => _HeightStepState();
}

class _HeightStepState extends State<HeightStep> {
  final c = TextEditingController();
  @override void dispose() { c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SetupViewModel>();
    if (c.text.isEmpty && vm.data.height != null) c.text = vm.data.height.toString();

    return StepScaffold(
      title: "Height",
      subtitle: "Enter your height (cm)",
      onBack: vm.step > 0 ? () => vm.back() : null,
      child: SizedBox(
        width: 220,
        child: AppTextField(
          hint: "e.g. 175",
          controller: c,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: vm.setHeight,
        ),
      ),
      bottom: AppButton(
        text: "NEXT",
        onPressed: vm.canGoNext ? () => vm.next() : null,
      ),
    );
  }
}

