import 'package:flutter/material.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/chat/components/ballon_message.dart';
import 'package:tcc_le_app/pages/chat/components/input_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DafaultLayout(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: CustomSpacing.xxs),
              child: Column(
                children: [
                  BallonMessage(text: "text", myMessage: false),
                  BallonMessage(text: "text asda dsa da d", myMessage: true),
                  BallonMessage(
                    text:
                        "lorem  ad sa sd asd as da sd as das d asd as das d as da",
                    myMessage: true,
                  ),
                  BallonMessage(
                    text:
                        "jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da ",
                    myMessage: false,
                  ),
                  BallonMessage(text: "text", myMessage: false),
                  BallonMessage(text: "text asda dsa da d", myMessage: true),
                  BallonMessage(
                    text:
                        "lorem  ad sa sd asd as da sd as das d asd as das d as da",
                    myMessage: true,
                  ),
                  BallonMessage(
                    text:
                        "jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da ",
                    myMessage: false,
                  ),
                  BallonMessage(text: "text", myMessage: false),
                  BallonMessage(text: "text asda dsa da d", myMessage: true),
                  BallonMessage(
                    text:
                        "lorem  ad sa sd asd as da sd as das d asd as das d as da",
                    myMessage: true,
                  ),
                  BallonMessage(
                    text:
                        "jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da ",
                    myMessage: false,
                  ),
                  BallonMessage(text: "text", myMessage: false),
                  BallonMessage(text: "text asda dsa da d", myMessage: true),
                  BallonMessage(
                    text:
                        "lorem  ad sa sd asd as da sd as das d asd as das d as da",
                    myMessage: true,
                  ),
                  BallonMessage(
                    text:
                        "jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da ",
                    myMessage: false,
                  ),
                  BallonMessage(text: "text", myMessage: false),
                  BallonMessage(text: "text asda dsa da d", myMessage: true),
                  BallonMessage(
                    text:
                        "lorem  ad sa sd asd as da sd as das d asd as das d as da",
                    myMessage: true,
                  ),
                  BallonMessage(
                    text:
                        "jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da ",
                    myMessage: false,
                  ),
                  BallonMessage(text: "text", myMessage: false),
                  BallonMessage(text: "text asda dsa da d", myMessage: true),
                  BallonMessage(
                    text:
                        "lorem  ad sa sd asd as da sd as das d asd as das d as da",
                    myMessage: true,
                  ),
                  BallonMessage(
                    text:
                        "jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da ",
                    myMessage: false,
                  ),
                  BallonMessage(text: "text", myMessage: false),
                  BallonMessage(text: "text asda dsa da d", myMessage: true),
                  BallonMessage(
                    text:
                        "lorem  ad sa sd asd as da sd as das d asd as das d as da",
                    myMessage: true,
                  ),
                  BallonMessage(
                    text:
                        "jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da jnferrrr rrrrrr das da sd a sd asd dddasdasa sad as da ",
                    myMessage: false,
                  ),
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
