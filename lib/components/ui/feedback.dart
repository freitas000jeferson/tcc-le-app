import 'package:flutter/material.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

enum FeedbackVariant { success, error, warn }

class CustomFeedback extends StatelessWidget {
  final bool condition;
  final String? message;
  final FeedbackVariant variant;

  const CustomFeedback({
    super.key,
    required this.condition,
    this.message = "",
    this.variant = FeedbackVariant.error,
  });

  TextStyle getVariantText() {
    if (variant == FeedbackVariant.error) {
      return CustomTextStyles.error;
    } else if (variant == FeedbackVariant.success) {
      return CustomTextStyles.success;
    } else if (variant == FeedbackVariant.warn) {
      return CustomTextStyles.warn;
    } else {
      return CustomTextStyles.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return condition
        ? Container(
          padding: CustomSpacing.squishXS,
          margin: EdgeInsets.only(top: CustomSpacing.xxs),
          decoration: BoxDecoration(
            color: CustomColors.neutralLightest,
            borderRadius: BorderRadius.circular(CustomBorders.radiusXS),
          ),
          child: Text(message ?? "", style: getVariantText()),
        )
        : Container();
  }
}
