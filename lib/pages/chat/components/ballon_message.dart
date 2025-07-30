import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/core/database/tables/message.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/chat/components/image_message.dart';
import 'package:tcc_le_app/pages/chat/controllers/chat_controller.dart';

class BallonMessage extends StatelessWidget {
  final ChatController _controller = Get.find<ChatController>();

  final Message message;
  late bool isUserMessage;
  final timeFormater = DateFormat('h:mm');
  final dateFormater = DateFormat("dd/MM");
  BallonMessage({super.key, required this.message}) {
    isUserMessage = message.from == 'me';
  }

  @override
  Widget build(BuildContext context) {
    if ((message.imageBody != null && message.imageBody!.isNotEmpty) ||
        (message.textBody != null && message.textBody!.isNotEmpty)) {
      return Column(
        crossAxisAlignment:
            isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (message.imageBody != null && message.imageBody!.isNotEmpty)
            ImageMessage(url: message.imageBody!, isUserMessage: isUserMessage),
          //
          if (message.textBody != null && message.textBody!.isNotEmpty)
            Row(
              mainAxisAlignment:
                  isUserMessage
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
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
                      message.textBody!,
                      color:
                          isUserMessage
                              ? CustomColors.background
                              : CustomColors.neutralDark,
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: CustomSpacing.xxxs),
          if (!message.isViewer &&
              message.buttonsBody != null &&
              message.buttonsBody!.isNotEmpty)
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: CustomSpacing.xxs,
              runSpacing: CustomSpacing.xxxs,
              children:
                  message.buttonsBody!
                      .map(
                        (button) => CustomButton(
                          variant: ButtonVariant.secondary,
                          onPressed: () async {
                            _controller.clickButton(
                              message: message,
                              content: button.title,
                            );
                          },
                          child: Text(
                            button.title,
                            style: CustomTextStyles.button,
                          ),
                        ),
                      )
                      .toList(),
            ),
          CustomText(
            "${timeFormater.format(message.userDate!)}- ${dateFormater.format(message.userDate!)}",
            fontSize: CustomFonts.xs,
          ),
        ],
      );
    }
    return Container();
  }
}
