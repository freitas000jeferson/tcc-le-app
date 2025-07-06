import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontFamily {
  // roboto
  base,
  // Lato
  highlight,
  // Sacramento
  logo,
}

class CustomFonts {
  /// @returns 4
  static const double xxxs = 4;

  /// @returns 8
  static const double xxs = 8;

  /// @returns 12
  static const double xs = 12;

  /// @returns 14
  static const double sm = 14;

  /// @returns 16
  static const double md = 16;

  /// @returns 18
  static const double lg = 18;

  /// @returns 20
  static const double xl = 20;

  /// @returns 24
  static const double xxl = 24;

  /// @returns 36
  static const double xxxl = 36;

  /// @returns 64
  static const double logoSize = 64;

  /// FontWeight: 900
  static const FontWeight weightBolder = FontWeight.w900;

  /// FontWeight: 700
  static const FontWeight weightBold = FontWeight.w700;

  /// FontWeight: 500
  static const FontWeight weightMedium = FontWeight.w500;

  /// FontWeight: 300
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightSmall = FontWeight.w300;

  /// FontFamily: 'Rubik'
  static const familyBase = 'Roboto';

  /// FontFamily: 'Rubik'
  static const familyHighlight = 'Rubik';

  /// FontFamily: 'Sacramento'
  static const familyLogo = 'Sacramento';
  TextStyle a = GoogleFonts.roboto();
  static getTextStyle(FontFamily family) {
    if (family == FontFamily.base) return GoogleFonts.roboto;
    if (family == FontFamily.highlight) return GoogleFonts.lato;
    if (family == FontFamily.logo) return GoogleFonts.sacramento;

    return GoogleFonts.roboto;
  }
}
