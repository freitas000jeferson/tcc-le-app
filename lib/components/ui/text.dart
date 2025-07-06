import 'package:flutter/material.dart';
import 'package:tcc_le_app/core/styles/colors.dart';
import 'package:tcc_le_app/core/styles/fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final FontStyle fontStyle;
  final FontFamily? family;
  late Function _style;

  CustomText(
    this.text, {
    super.key,
    this.family = FontFamily.base,
    this.color = CustomColors.neutralDark,
    this.fontSize = CustomFonts.md,
    this.fontWeight = CustomFonts.weightRegular,
    this.textAlign = TextAlign.left,
    this.fontStyle = FontStyle.normal,
  }) {
    _style = CustomFonts.getTextStyle(family!);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: _style(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    );
  }
}
