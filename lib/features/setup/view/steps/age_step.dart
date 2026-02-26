import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/core/widgets/step_scaffold.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_button.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_text_field.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/setup_viewmodel.dart';



class AgeStep extends StatefulWidget {
  const AgeStep({super.key});
  @override State<AgeStep> createState() => _AgeStepState();
}

class _AgeStepState extends State<AgeStep> {
  final c = TextEditingController();
  @override void dispose() { c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SetupViewModel>();
    if (c.text.isEmpty && vm.data.age != null) c.text = vm.data.age.toString();

    return StepScaffold(
      title: "Age",
      subtitle: "How old are you?",
      onBack: vm.step > 0 ? () => vm.back() : null,
      child: SizedBox(
        width: 220,
        child: AppTextField(
          hint: "Enter your age",
          controller: c,
          keyboardType: TextInputType.number,
          onChanged: vm.setAge,
        ),
      ),
      bottom: AppButton(
        text: "NEXT",
        onPressed: vm.canGoNext ? () => vm.next() : null,
      ),
    );
  }
}
