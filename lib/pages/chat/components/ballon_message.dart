import 'package:flutter/material.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

class BallonMessage extends StatelessWidget {
  final String text;
  final List<String>? buttons;
  final bool? isViewer;
  final bool myMessage;

  const BallonMessage({
    super.key,
    required this.text,
    this.buttons,
    this.isViewer = false,
    this.myMessage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: CustomSpacing.xxs,
              right: myMessage ? 0 : CustomSpacing.lg,
              left: myMessage ? CustomSpacing.lg : 0,
            ),
            padding: CustomSpacing.squishXS,
            decoration: BoxDecoration(
              color:
                  myMessage ? CustomColors.primary : CustomColors.primaryLight,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  myMessage ? CustomBorders.radiusNone : CustomBorders.radiusMD,
                ),
                bottomLeft: Radius.circular(
                  myMessage ? CustomBorders.radiusMD : CustomBorders.radiusNone,
                ),
                topLeft: Radius.circular(CustomBorders.radiusMD),
                topRight: Radius.circular(CustomBorders.radiusMD),
              ),
              boxShadow: [CustomShadow.shadow],
            ),
            child: CustomText(
              text,
              color:
                  myMessage
                      ? CustomColors.background
                      : CustomColors.neutralDark,
            ),
          ),
        ),
      ],
    );
  }
}
