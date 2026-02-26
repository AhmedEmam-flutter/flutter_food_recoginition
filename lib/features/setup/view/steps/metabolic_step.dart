import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/setup/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/setup_viewmodel.dart';
import '../../../../core/widgets/step_scaffold.dart';

class MetabolicStep extends StatelessWidget {
  const MetabolicStep({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SetupViewModel>();
    final d = vm.data;
    final err = vm.error;

    if (vm.isLoading) {
      return StepScaffold(
        title: "Metabolic Profile",
        subtitle: "Your estimated daily calories",
        onBack: vm.step > 0 ? () => vm.back() : null,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        bottom: const AppButton(
          text: "CONTINUE",
          onPressed: null,
        ),
      );
    }

    if (err != null && err.isNotEmpty) {
      return StepScaffold(
        title: "Metabolic Profile",
        subtitle: "Your estimated daily calories",
        onBack: vm.step > 0 ? () => vm.back() : null,
        child: Center(
          child: Text(
            err,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
        bottom: AppButton(
          text: "TRY AGAIN",
          onPressed: () => vm.next(),
        ),
      );
    }

    return StepScaffold(
      title: "Metabolic Profile",
      subtitle: "Your estimated daily calories",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Maintenance (AMR)",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (d.maintenanceCalories ?? 0).toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "cal",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Daily Target",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xFF1E88FF), // أزرق زي الصورة
                width: 3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (d.dailyTarget ?? 0).toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "cal",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: AppButton(
        text: "CONTINUE",
        onPressed: () => vm.next(),
      ),
    );
  }
}
