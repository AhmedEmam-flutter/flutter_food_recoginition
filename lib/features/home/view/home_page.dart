import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utiles/color_manager.dart';
import '../viewmodel/home_view_model.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/recent_foods_list.dart';
import '../widgets/today_progress_card.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = HomeViewModel();
        vm.init();
        return vm;
      },
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: vm.selectedTab,
        onChanged: vm.changeTab,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.015),
          child: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.01),

                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: w * 0.07,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.textColor,
                        ),
                      ),

                      SizedBox(height: h * 0.02),

                      Text(
                        "Good afternoon Ahmed 👋",
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textColor,
                        ),
                      ),

                      Text(
                        "Let’s track your nutrition today",
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: ColorManager.textColor,
                        ),
                      ),

                      SizedBox(height: h * 0.02),

                      TodayProgressCard(progress: vm.progress!),

                      SizedBox(height: h * 0.025),

                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.textColor,
                        ),
                      ),

                      SizedBox(height: h * 0.01),
                      QuickActionsGrid(
                        onScan: () {},
                        onAskAi: () {},
                        onStats: () {},
                        onManual: () {},
                      ),

                      SizedBox(height: h * 0.02),

                      Text(
                        "Recent Foods",
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.textColor,
                        ),
                      ),

                      SizedBox(height: h * 0.01),
                      RecentFoodsList(items: vm.recentFoods),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

