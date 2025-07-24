import 'package:flutter/material.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/chat/components/input_message.dart';

class ChatPage extends StatelessWidget {
  // final ChatController _controller =
  //     Get.isRegistered<ChatController>()
  //         ? Get.find<ChatController>()
  //         : Get.put(ChatController());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DafaultLayout(
            // child: Obx(
            //   () => ListView(
            //     children:
            //         _controller.messages
            //             .map((item) => BallonMessage(message: item))
            //             .toList(),
            //   ),
            // ),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: CustomSpacing.xxs),
              child: Column(
                children: [
                  // BallonMessage(text: "text", myMessage: false),
                ],
              ),
            ),
          ),
        ),
        InputMessage(),
      ],
    );
  }
}
