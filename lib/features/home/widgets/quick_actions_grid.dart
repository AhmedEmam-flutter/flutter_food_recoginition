import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onScan;
  final VoidCallback onAskAi;
  final VoidCallback onStats;
  final VoidCallback onManual;

  const QuickActionsGrid({
    super.key,
    required this.onScan,
    required this.onAskAi,
    required this.onStats,
    required this.onManual,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final pad = w * 0.03;
    final radius = w * 0.04;
    final gap = w * 0.025;

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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ActionTile(
                  title: "Scan Your Food",
                  icon: Icons.camera_alt_outlined,
                  bg: ColorManager.primaryColor.withValues(alpha: 0.18),
                  onTap: onScan,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: InkWell(
                  onTap: (){
                    
                  },
                  child: _ActionTile(
                    title: "Ask AI",
                    icon: Icons.psychology_alt_outlined,
                    bg: ColorManager.primaryColor.withValues(alpha: 0.18),
                    onTap: onAskAi,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: gap),
          Row(
            children: [
              Expanded(
                child: _ActionTile(
                  title: "View Stats",
                  icon: Icons.show_chart,
                  bg: Colors.black.withValues(alpha: 0.04),
                  onTap: onStats,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _ActionTile(
                  title: "Add Manually",
                  icon: Icons.add,
                  bg: Colors.black.withValues(alpha: 0.04),
                  onTap: onManual,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bg;
  final VoidCallback onTap;

  const _ActionTile({
    required this.title,
    required this.icon,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final radius = w * 0.035;
    final tileH = (h * 0.075).clamp(52.0, 72.0); 
    final iconSize = (w * 0.055).clamp(18.0, 24.0);
    final fontSize = (w * 0.032).clamp(11.0, 14.0);
    final padH = w * 0.03;
    final gap = w * 0.02;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Container(
          height: tileH,
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: Row(
            children: [
              Icon(icon, color: ColorManager.textColor, size: iconSize),
              SizedBox(width: gap),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
