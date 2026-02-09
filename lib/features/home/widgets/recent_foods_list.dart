import 'package:flutter/material.dart';
import '../../../core/utiles/color_manager.dart';
import '../viewmodel/home_view_model.dart';

class RecentFoodsList extends StatelessWidget {
  final List<RecentFoodUiModel> items;

  const RecentFoodsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((e) => _RecentFoodTile(item: e)).toList(),
    );
  }
}

class _RecentFoodTile extends StatelessWidget {
  final RecentFoodUiModel item;

  const _RecentFoodTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final radius = w * 0.04;
    final imgW = (w * 0.3).clamp(46.0, 66.0);
    final imgH = (h * 0.1).clamp(38.0, 54.0);
    final pad = w * 0.03;
    final gap = w * 0.025;

    final nameFs = (w * 0.038).clamp(12.0, 16.0);
    final timeFs = (w * 0.032).clamp(10.0, 13.0);
    final badgeFs = (w * 0.03).clamp(10.0, 12.0);

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.012),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(w * 0.035),
            child: (item.imageAsset == null)
                ? _fallback(imgW, imgH, w)
                : Image.asset(
                    item.imageAsset!,
                    width: imgW,
                    height: imgH,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _fallback(imgW, imgH, w),
                  ),
          ),
          SizedBox(width: gap),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: nameFs,
                    fontWeight: FontWeight.w800,
                    color: ColorManager.textColor,
                  ),
                ),
                SizedBox(height: h * 0.003),
                Text(
                  item.time,
                  style: TextStyle(
                    fontSize: timeFs,
                    color: ColorManager.lightGrey.withValues(alpha: 0.95),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.028,
              vertical: h * 0.006,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              "${item.calories} cal",
              style: TextStyle(
                fontSize: badgeFs,
                fontWeight: FontWeight.w700,
                color: ColorManager.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallback(double imgW, double imgH, double w) {
    return Container(
      width: imgW,
      height: imgH,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(w * 0.035),
      ),
      child: Icon(Icons.fastfood, size: (w * 0.05).clamp(16.0, 22.0)),
    );
  }
}
