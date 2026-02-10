import 'package:flutter/material.dart';
import 'package:flutter_food_recoginition/features/auth/presention/login_page.dart';
import '../../../core/utiles/color_manager.dart';

class ProfileSettingsCard extends StatelessWidget {
  final VoidCallback onNotifications;
  final VoidCallback onPrivacy;
  final VoidCallback onHelp;
  final VoidCallback onSignOut;

  const ProfileSettingsCard({
    super.key,
    required this.onNotifications,
    required this.onPrivacy,
    required this.onHelp,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: w * 0.04,
            offset: Offset(0, h * 0.007),
          ),
        ],
      ),
      child: Column(
        children: [
          _RowItem(
              icon: Icons.notifications_none,
              title: "Notifications",
              onTap: onNotifications),
          _divider(),
          _RowItem(
              icon: Icons.lock_outline,
              title: "Privacy & Data",
              onTap: onPrivacy),
          _divider(),
          _RowItem(
              icon: Icons.help_outline, title: "Help & Support", onTap: onHelp),
          _divider(),
          _RowItem(
              icon: Icons.logout,
              title: "Sign Out",
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginPage.routeName,
                  (route) => false, 
                );
              },
              isDanger: true),
        ],
      ),
    );
  }

  Widget _divider() => Divider(
      height: 1, thickness: 1, color: Colors.black.withValues(alpha: 0.06));
}

class _RowItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDanger;

  const _RowItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    final color = isDanger ? Colors.red : ColorManager.textColor;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: w * 0.04, vertical: (h * 0.015).clamp(10.0, 14.0)),
        child: Row(
          children: [
            Icon(icon, color: color, size: (w * 0.05).clamp(18.0, 22.0)),
            SizedBox(width: w * 0.03),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: (w * 0.035).clamp(12.0, 15.0),
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.chevron_right,
                color: ColorManager.lightGrey,
                size: (w * 0.06).clamp(20.0, 26.0)),
          ],
        ),
      ),
    );
  }
}
