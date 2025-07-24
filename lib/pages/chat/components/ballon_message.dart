import 'package:flutter/material.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/core/database/tables/message.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

class BallonMessage extends StatelessWidget {
  final Message message;
  late bool isUserMessage;
  BallonMessage({super.key, required this.message}) {
    isUserMessage = message.from == 'me';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              top: CustomSpacing.xxs,
              right: isUserMessage ? 0 : CustomSpacing.lg,
              left: isUserMessage ? CustomSpacing.lg : 0,
            ),
            padding: CustomSpacing.squishXS,
            decoration: BoxDecoration(
              color:
                  isUserMessage
                      ? CustomColors.primary
                      : CustomColors.primaryLight,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  isUserMessage
                      ? CustomBorders.radiusNone
                      : CustomBorders.radiusMD,
                ),
                bottomLeft: Radius.circular(
                  isUserMessage
                      ? CustomBorders.radiusMD
                      : CustomBorders.radiusNone,
                ),
                topLeft: Radius.circular(CustomBorders.radiusMD),
                topRight: Radius.circular(CustomBorders.radiusMD),
              ),
              boxShadow: [CustomShadow.shadow],
            ),
            child: CustomText(
              message.textBody,
              color:
                  isUserMessage
                      ? CustomColors.background
                      : CustomColors.neutralDark,
            ),
          ),
        ),
      ],
    );
  }
}
