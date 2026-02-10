import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileTopCard extends StatelessWidget {
  final ProfileUiModel model;
  final VoidCallback onEdit;

  const ProfileTopCard({super.key, required this.model, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    final radius = w * 0.04;
    final pad = w * 0.035;
    final nameFs = (w * 0.042).clamp(14.0, 18.0);
    final emailFs = (w * 0.032).clamp(11.0, 14.0);

    return Container(
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: w * 0.04,
            offset: Offset(0, h * 0.007),
          ),
        ],
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: (w * 0.06).clamp(22.0, 30.0),
            backgroundColor: ColorManager.primaryColor.withValues(alpha: 0.18),
            child: Icon(Icons.person_outline, color: ColorManager.textColor, size: (w * 0.06).clamp(18.0, 26.0)),
          ),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name, style: TextStyle(fontSize: nameFs, fontWeight: FontWeight.w800, color: ColorManager.textColor)),
                SizedBox(height: h * 0.003),
                Text(model.email, style: TextStyle(fontSize: emailFs, color: ColorManager.lightGrey.withValues(alpha: 0.95))),
              ],
            ),
          ),
          _EditButton(onTap: onEdit),
        ],
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  final VoidCallback onTap;
  const _EditButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final w = s.width;
    final h = s.height;

    return Material(
      color: ColorManager.primaryColor.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.035,
            vertical: (h * 0.008).clamp(6.0, 10.0),
          ),
          child: Text(
            "Edit",
            style: TextStyle(
              fontSize: (w * 0.032).clamp(11.0, 14.0),
              fontWeight: FontWeight.w800,
              color: ColorManager.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
