library;

import 'package:flutter/material.dart';

class Breakpoint {
  Breakpoint._();

  static const double phone = 600;
  static const double tablet = 840;
  static const double desktop = 1200;

  static const double maxContentWidth = 600;
}

class Responsive {
  Responsive._();

  static bool isTabletOrLarger(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return width >= Breakpoint.tablet || height >= Breakpoint.tablet;
  }

  static bool isWide(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= Breakpoint.phone;
  }

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoint.desktop) return 32;
    if (width >= Breakpoint.tablet) return 24;
    if (width >= Breakpoint.phone) return 20;
    return 16;
  }

  static double verticalPadding(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    if (height >= 800) return 24;
    if (height >= 600) return 16;
    return 12;
  }

  static EdgeInsets contentPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding(context),
      vertical: verticalPadding(context),
    );
  }

  static Widget constrainToMaxWidth(BuildContext context, Widget child) {
    final width = MediaQuery.sizeOf(context).width;
    if (width <= Breakpoint.maxContentWidth) return child;
    return Center(
      child: SizedBox(width: Breakpoint.maxContentWidth, child: child),
    );
  }

  static EdgeInsets safePadding(BuildContext context) {
    return MediaQuery.paddingOf(context);
  }

  static EdgeInsets viewInsets(BuildContext context) {
    return MediaQuery.viewInsetsOf(context);
  }
}
