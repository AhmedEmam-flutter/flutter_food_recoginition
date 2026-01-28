// file name: home_screen.dart

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/home/tabs/home_tab.dart';
import 'package:flutter_food_recoginition/features/home/tabs/profile_tab.dart';
import 'package:flutter_food_recoginition/features/home/tabs/scan_tab.dart';
import 'package:flutter_food_recoginition/features/home/tabs/stats_tab.dart';

import '../../core/utiles/color_manager.dart';
import '../../core/utiles/rsponsive_manger.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = const [
    HomeTab(),
    ScanTab(),
    StatsTab(),
    ProfileTab(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ResponsiveManager.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _tabs[_selectedIndex],
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildNavigationBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: NavigationBarTheme(
              data: const NavigationBarThemeData(
                height: 75,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                indicatorShape: StadiumBorder(),
              ),
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                backgroundColor: Colors.white,
                indicatorColor: ColorManager.primaryColor,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined, color: Colors.grey),
                    selectedIcon: Icon(Icons.home, color: Colors.white),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.camera_alt_outlined, color: Colors.grey),
                    selectedIcon: Icon(Icons.camera_alt, color: Colors.white),
                    label: 'Scan',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.bar_chart_outlined, color: Colors.grey),
                    selectedIcon: Icon(Icons.bar_chart, color: Colors.white),
                    label: 'Stats',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline, color: Colors.grey),
                    selectedIcon: Icon(Icons.person, color: Colors.white),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
