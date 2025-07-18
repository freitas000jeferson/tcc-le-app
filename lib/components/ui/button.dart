import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

enum ButtonVariant { primary, secondary, tertiary, danger }

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final bool enable;
  final bool isLoading;
  late Function()? _onPressed;
  late Function(bool)? onHover;
  late Function(bool)? onFocusChange;
  final ButtonVariant? variant;
  late Color _bgColor;
  late Color _bgDisableColor;
  late Color _fgColor;
  late Color _fgDisableColor;
  final bool? fullSize;
  final EdgeInsetsGeometry? padding;

  CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.enable = true,
    this.variant = ButtonVariant.primary,
    this.fullSize = false,
    this.isLoading = false,
    this.onHover,
    this.onFocusChange,
    this.padding,
  }) {
    _onPressed = enable && !isLoading ? onPressed : null;
    setBackgrounds();
  }
  void setBackgrounds() {
    switch (variant) {
      case ButtonVariant.primary:
        _bgColor = CustomColors.primary;
        _bgDisableColor = CustomColors.primaryLight;

        _fgColor = CustomColors.neutralLightest;
        _fgDisableColor = CustomColors.neutralLightest;
        break;
      case ButtonVariant.secondary:
        _bgColor = CustomColors.secondary;
        _bgDisableColor = CustomColors.secondaryLight;

        _fgColor = CustomColors.neutralLightest;
        _fgDisableColor = CustomColors.neutralLightest;
        break;
      case ButtonVariant.tertiary:
        _bgColor = CustomColors.tertiary;
        _bgDisableColor = CustomColors.tertiaryLight;

        _fgColor = CustomColors.neutralDark;
        _fgDisableColor = CustomColors.neutralMedium;
        break;
      default:
        _bgColor = CustomColors.primary;
        _bgDisableColor = CustomColors.primaryLight;

        _fgColor = CustomColors.neutralLightest;
        _fgDisableColor = CustomColors.neutralLightest;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullSize! ? double.infinity : null,
      child: ElevatedButton(
        onPressed: _onPressed,
        key: key,
        onHover: onHover,

        onFocusChange: onFocusChange,
        style: ElevatedButton.styleFrom(
          foregroundColor: _fgColor,
          disabledForegroundColor: _fgDisableColor,
          backgroundColor: _bgColor,
          disabledBackgroundColor: isLoading ? _bgColor : _bgDisableColor,
          padding: padding ?? CustomSpacing.squishSM,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              CustomBorders.radiusSM,
            ), // <-- Radius
          ),
        ),
        child:
            isLoading
                ? Container(
                  width: 28,
                  child: SpinKitWave(size: 18, color: _fgColor),
                )
                : child,
      ),
    );
  }
}
