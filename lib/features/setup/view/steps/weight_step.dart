import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_button.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/setup_viewmodel.dart';
import '../../../../core/widgets/step_scaffold.dart';

class WeightStep extends StatefulWidget {
  const WeightStep({super.key});
  @override State<WeightStep> createState() => _WeightStepState();
}

class _WeightStepState extends State<WeightStep> {
  final c = TextEditingController();
  @override void dispose() { c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SetupViewModel>();
    if (c.text.isEmpty && vm.data.weight != null) c.text = vm.data.weight.toString();

    return StepScaffold(
      title: "Weight",
      subtitle: "Enter your weight (kg)",
      child: SizedBox(
        width: 220,
        child: AppTextField(
          hint: "e.g. 72",
          controller: c,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: vm.setWeight,
        ),
      ),
      bottom: AppButton(
        text: "NEXT",
        onPressed: vm.canGoNext ? () => vm.next() : null,
      ),
    );
  }
}
