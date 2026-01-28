// file name: rsponsive_manger.dart
import 'package:flutter/material.dart';

class ResponsiveManager {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late Orientation orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  static double getResponsiveFontSize(double baseSize) {
    if (screenWidth < 360) return baseSize * 0.8;
    if (screenWidth < 600) return baseSize * 0.9;
    if (screenWidth < 900) return baseSize;
    return baseSize * 1.1;
  }

  static EdgeInsets getResponsivePadding() {
    if (screenWidth < 600) {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    } else if (screenWidth < 900) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
    } else {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    }
  }

  static double getResponsiveValue({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (screenWidth >= 900) return desktop ?? tablet ?? mobile;
    if (screenWidth >= 600) return tablet ?? mobile;
    return mobile;
  }

  static bool get isMobile => screenWidth < 600;

  static bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  static bool get isDesktop => screenWidth >= 900;

  static bool get isLandscape => orientation == Orientation.landscape;
}
