import 'package:flutter/material.dart';
import 'package:tcc_le_app/core/styles/colors.dart';
import 'package:tcc_le_app/core/styles/fonts.dart';

enum TitleVariant { xs, sm, md, lg }

class CustomTitle extends StatelessWidget {
  final String text;
  late Color? color;
  late double? fontSize;
  late FontWeight? fontWeight;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TitleVariant? variant;
  final FontFamily? family;
  late Function _style;
  CustomTitle(
    this.text, {
    super.key,
    this.family = FontFamily.highlight,
    this.color = CustomColors.neutralDarkest,
    this.fontSize = CustomFonts.xxxl,
    this.fontWeight = CustomFonts.weightBold,
    this.textAlign = TextAlign.left,
    this.fontStyle = FontStyle.normal,
    this.variant,
  }) {
    this._style = CustomFonts.getTextStyle(family!);
    switch (variant) {
      case TitleVariant.xs:
        color = CustomColors.neutralDarkest;
        fontSize = CustomFonts.xl;
        fontWeight = CustomFonts.weightMedium;
        break;
      case TitleVariant.sm:
        color = CustomColors.neutralDarkest;
        fontSize = CustomFonts.xl;
        fontWeight = CustomFonts.weightBold;
        break;

      case TitleVariant.md:
        color = CustomColors.neutralDarkest;
        fontSize = CustomFonts.xxl;
        fontWeight = CustomFonts.weightBolder;
        break;

      case TitleVariant.lg:
        color = CustomColors.neutralDarkest;
        fontSize = CustomFonts.xxxl;
        fontWeight = CustomFonts.weightBolder;
        break;

      default:
        break;
    }
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
      // style: TextStyle(
      //   color: color,
      //   fontSize: fontSize,
      //   fontWeight: fontWeight,
      //   fontFamily: fontFamily,
      //   fontStyle: fontStyle,
      // ),
    );
  }
}
