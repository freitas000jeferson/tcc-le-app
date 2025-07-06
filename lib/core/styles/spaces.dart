import 'package:flutter/cupertino.dart';

class SpacingSymmetric {
  late double _vertical;
  late double _horizontal;
  SpacingSymmetric({required double vertical, required double horizontal}) {
    _horizontal = horizontal;
    _vertical = vertical;
  }

  /// spacing vertical
  double get vertical => _vertical;

  /// spacing horizontal
  double get horizontal => _horizontal;
}

class CustomSpacing {
  /// value: 4
  static const double xxxs = 4;

  /// value: 8
  static const double xxs = 8;

  /// value: 16
  static const double xs = 16;

  /// value: 24
  static const double sm = 24;

  /// value: 32
  static const double md = 32;

  /// value: 48
  static const double lg = 48;

  /// value: 64
  static const double xl = 64;

  /// value: 96
  static const double xxl = 96;

  /// value: 128
  static const double xxxl = 128;

  /// vertical: 4, horizontal: 8
  static EdgeInsets squishXXXS = EdgeInsets.symmetric(
    vertical: 4,
    horizontal: 8,
  );

  /// vertical: 4, horizontal: 16
  static EdgeInsets squishXXS = EdgeInsets.symmetric(
    vertical: 4,
    horizontal: 16,
  );

  /// vertical: 8, horizontal: 16
  static EdgeInsets squishXS = EdgeInsets.symmetric(
    vertical: 8,
    horizontal: 16,
  );

  /// vertical: 8, horizontal: 24
  static EdgeInsets squishSM = EdgeInsets.symmetric(
    vertical: 8,
    horizontal: 24,
  );

  /// vertical: 16, horizontal: 24
  static EdgeInsets squishMD = EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 24,
  );

  /// vertical: 16, horizontal: 32
  static EdgeInsets squishLG = EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 32,
  );

  /// vertical: 24, horizontal: 32
  static EdgeInsets squishXL = EdgeInsets.symmetric(
    vertical: 24,
    horizontal: 32,
  );

  /// vertical: 32, horizontal: 48
  static EdgeInsets squishXXL = EdgeInsets.symmetric(
    vertical: 24,
    horizontal: 48,
  );
}
