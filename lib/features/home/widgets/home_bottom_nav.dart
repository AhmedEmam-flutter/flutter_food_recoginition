import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/profile/view/profile_page.dart';
import 'package:flutter_food_recoginition/features/scan/scan.dart';
import '../../../core/utiles/color_manager.dart';

class HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const HomeBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black.withValues(alpha: 0.06))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Item(
              icon: Icons.home_filled,
              label: "Home",
              active: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
            _Item(
              icon: Icons.camera_alt_outlined,
              label: "Scan",
              active: selectedIndex == 1,
              onTap: (){
    onChanged(3); 
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanTab()));
  },
            ),
            _Item(
              icon: Icons.show_chart,
              label: "Stats",
              active: selectedIndex == 2,
              onTap: () => onChanged(2),
            ),
           _Item(
  icon: Icons.person_outline,
  label: "Profile",
  active: selectedIndex == 3,
  onTap: () {
    onChanged(3); 
    Navigator.pushNamed(context, ProfilePage.routeName);
  },
),

          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _Item({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? ColorManager.primaryColor : ColorManager.lightGrey;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
