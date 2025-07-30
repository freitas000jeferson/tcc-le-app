import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/chat/components/ballon_message.dart';
import 'package:tcc_le_app/pages/chat/components/input_message.dart';
import 'package:tcc_le_app/pages/chat/controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ScrollController _scrollController;
  final ChatController _controller = Get.find<ChatController>();
  bool showJumpButton = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // Detecta se chegou ao topo
      if (_scrollController.position.pixels <= 60) {
        _controller.findOlderMessages();
      }

      // Mostra botão se não está no fim
      if (_scrollController.position.pixels <
          _scrollController.position.maxScrollExtent - 500) {
        if (!showJumpButton) setState(() => showJumpButton = true);
      } else {
        if (showJumpButton) setState(() => showJumpButton = false);
      }
    });
    ever(_controller.shouldScrollToBottom, (shouldScroll) {
      if (shouldScroll == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
            _controller.shouldScrollToBottom.value = false; // reseta
          }
        });
      }
    });
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DafaultLayout(
            child: Obx(() {
              final messages = _controller.messages;

              if (_controller.isLoading.value && messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (messages.isEmpty) {
                return Center(child: CustomText("No messages found!"));
              }

              return Stack(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: CustomSpacing.xs),
                    controller: _scrollController,
                    itemCount:
                        messages.length + (_controller.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == 0 && _controller.isLoading.value) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (index >= messages.length) {
                        return const SizedBox.shrink();
                      }
                      final realIndex =
                          _controller.isLoading.value ? index - 1 : index;
                      return BallonMessage(message: messages[realIndex]);
                    },
                  ),
                  if (showJumpButton)
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton.small(
                        backgroundColor: CustomColors.primary,

                        onPressed: scrollToBottom,
                        child: const Icon(
                          Icons.arrow_downward,
                          color: CustomColors.neutralLightest,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
        InputMessage(),
      ],
    );
  }
}
