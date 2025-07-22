import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

class CustomTextStyles {
  static TextStyle body = GoogleFonts.roboto(
    color: CustomColors.neutralDark,
    fontSize: CustomFonts.md,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );

  static TextStyle button = GoogleFonts.roboto(
    fontSize: CustomFonts.md,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );

  static TextStyle highlight = GoogleFonts.roboto(
    color: CustomColors.primary,
    fontSize: CustomFonts.md,
    fontWeight: CustomFonts.weightBold,
    fontStyle: FontStyle.normal,
  );

  static TextStyle caption = GoogleFonts.roboto(
    color: CustomColors.neutralDark,
    fontSize: CustomFonts.sm,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );

  static TextStyle small = GoogleFonts.roboto(
    color: CustomColors.neutralDark,
    fontSize: CustomFonts.xs,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );
  static TextStyle input = GoogleFonts.roboto(
    color: CustomColors.neutralDark,
    fontSize: CustomFonts.sm,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );
  static TextStyle inputHint = GoogleFonts.roboto(
    color: CustomColors.neutralMedium,
    fontSize: CustomFonts.sm,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );
  static TextStyle logo = GoogleFonts.roboto(
    color: CustomColors.neutralDark,
    fontSize: CustomFonts.xxl,
    fontWeight: CustomFonts.weightBold,
    fontStyle: FontStyle.normal,
  );

  static TextStyle logo2 = GoogleFonts.roboto(
    color: CustomColors.secondary,
    fontSize: CustomFonts.xxl,
    fontWeight: CustomFonts.weightBolder,
    fontStyle: FontStyle.normal,
  );
  static TextStyle menu = GoogleFonts.roboto(
    fontSize: CustomFonts.sm,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );

  static TextStyle error = GoogleFonts.roboto(
    color: CustomColors.feedbackError,
    fontSize: CustomFonts.sm,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );
  static TextStyle success = GoogleFonts.roboto(
    color: CustomColors.feedbackSuccess,
    fontSize: CustomFonts.sm,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );
  static TextStyle warn = GoogleFonts.roboto(
    color: CustomColors.feedbackWarn,
    fontSize: CustomFonts.sm,
    fontWeight: CustomFonts.weightMedium,
    fontStyle: FontStyle.normal,
  );
}
