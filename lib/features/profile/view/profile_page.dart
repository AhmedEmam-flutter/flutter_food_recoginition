import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utiles/color_manager.dart';
import '../viewmodel/profile_view_model.dart';
import '../widgets/profile_goal_card.dart';
import '../widgets/profile_info.dart';
import '../widgets/profile_section_title.dart';
import '../widgets/profile_settings_card.dart';
import '../widgets/profile_top_card.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = ProfileViewModel();
        vm.init();
        return vm;
      },
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final model = vm.data ?? ProfileUiModel.empty();

    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.015),
          child: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (vm.error != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: h * 0.01),
                          child: Text(
                            vm.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      ProfileTopCard(model: model, onEdit: () {}),
                      SizedBox(height: h * 0.02),

                      const ProfileSectionTitle(icon: Icons.info_outline, title: "Basic Information"),
                      SizedBox(height: h * 0.01),
                      ProfileBasicInfoGrid(model: model),
                      SizedBox(height: h * 0.02),

                      const ProfileSectionTitle(icon: Icons.flag_outlined, title: "Current Goal"),
                      SizedBox(height: h * 0.01),
                      ProfileGoalCard(model: model),
                      SizedBox(height: h * 0.02),

                      const ProfileSectionTitle(icon: Icons.settings_outlined, title: "App Settings"),
                      SizedBox(height: h * 0.01),
                      ProfileSettingsCard(
                        onNotifications: () {},
                        onPrivacy: () {},
                        onHelp: () {},
                        onSignOut: () {},
                      ),

                      SizedBox(height: h * 0.03),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
