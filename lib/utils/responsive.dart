import 'package:flutter/material.dart';

/// Clean MediaQuery-based responsive extension on BuildContext
extension ResponsiveContext on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get screenPadding => mediaQuery.padding;
  EdgeInsets get screenViewInsets => mediaQuery.viewInsets;
  Orientation get orientation => mediaQuery.orientation;
  TextScaler get textScaler => mediaQuery.textScaler;

  bool get isTablet => screenWidth >= 600;
  bool get isDesktop => screenWidth >= 1024;
  bool get isSmallPhone => screenWidth < 360 || screenHeight < 680;
  bool get isLandscape => orientation == Orientation.landscape;

  /// Responsive horizontal screen padding
  double get responsiveHorizontalPadding {
    if (isDesktop) return 40.0;
    if (isTablet) return 32.0;
    if (isSmallPhone) return 14.0;
    return 20.0;
  }

  /// Responsive vertical screen padding
  double get responsiveVerticalPadding {
    if (isSmallPhone) return 8.0;
    if (isTablet) return 20.0;
    return 14.0;
  }

  /// Responsive content maximum constraint width for centered cards
  double get maxContentWidth {
    if (isDesktop) return 720.0;
    if (isTablet) return 620.0;
    return 480.0;
  }

  /// Responsive value helper
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? smallPhone,
  }) {
    if (isSmallPhone && smallPhone != null) return smallPhone;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}

