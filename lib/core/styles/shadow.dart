import 'package:flutter/widgets.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

class CustomShadow {
  /// @returns 0.0
  static const offsetXNone = 0.0;

  /// @returns 4.0
  static const offsetYSM = 4.0;

  /// @returns 8.0
  static const offsetYMD = 8.0;

  /// @returns 16.0
  static const offsetYLG = 16.0;

  /// @returns 4.0
  static const blurSM = 4.0;

  /// @returns 8.0
  static const blurMD = 8.0;

  /// @returns 16.0
  static const blurLG = 16.0;

  /// @returns 24.0
  static const blurXL = 24.0;

  /// @returns 0.0
  static const spreadRadiusNone = 0.0;
  static const spreadRadiusXS = 2.0;

  /// @returns 4.0
  static const spreadRadiusSM = 4.0;

  /// @returns 8.0
  static const spreadRadiusMD = 8.0;

  /// @returns 16.0
  static const spreadRadiusLG = 16.0;
  static const shadow = BoxShadow(
    color: CustomColors.shadow,
    blurRadius: CustomShadow.blurSM,
    spreadRadius: CustomShadow.spreadRadiusXS,
    offset: Offset(CustomShadow.offsetXNone, CustomShadow.offsetYSM),
  );
}
