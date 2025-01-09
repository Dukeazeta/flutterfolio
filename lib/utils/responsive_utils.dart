import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 50);
    } else {
      return EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1);
    }
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return MediaQuery.of(context).size.width - 40;
    } else if (isTablet(context)) {
      return 900;
    } else {
      return 1200;
    }
  }
}
