import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/core/database/repository/messages_repository.dart';
import 'package:tcc_le_app/core/database/tables/message.dart';
import 'package:tcc_le_app/core/domain/send_message_dto.dart';
import 'package:tcc_le_app/core/domain/user_profile.dart';
import 'package:tcc_le_app/core/http/utils/profile_storage.dart';
import 'package:tcc_le_app/core/utils/failures.dart';
import 'package:tcc_le_app/core/websocket/websocket_service.dart';

class ChatController extends GetxController {
  final WebSocketService _socket = WebSocketService();
  final MessagesRepository _messagesRepository = MessagesRepository();
  final ProfileStorage _profileStorage = ProfileStorage();

  late UserProfile? profile;
  Message? lastMessage;

  RxList<Message> messages = <Message>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;

  final textController = TextEditingController();
  var isButtonEnabled = false.obs;
  final RxBool shouldScrollToBottom = false.obs;

  ChatController() {
    textController.addListener(_handleInputChange);
    profile = _profileStorage.fetch();
  }

  void _handleInputChange() {
    isButtonEnabled.value = textController.text.trim().isNotEmpty;
  }

  Future sendMessage() async {
    final content = textController.text.trim();
    if (content.isEmpty) return;

    // atualizar o isViewer da ultima msg
    Message? lastMessage = messages.lastOrNull;
    if (lastMessage != null && !lastMessage.isViewer) {
      lastMessage.isViewer = true;
      await _messagesRepository.update(lastMessage);
      messages[messages.length - 1] = lastMessage;
    }

    await _sendAndSaveMessage(content);
  }

  Future _sendAndSaveMessage(String content) async {
    final date = DateTime.now();
    SendMessageDto sendMessage = SendMessageDto(
      message: content,
      userDate: date,
    );
    textController.clear();

    _socket.emit('send-message', sendMessage.toJson());
    await _saveNewMessage(content: content, date: date);
  }

  Future _saveNewMessage({
    required DateTime date,
    required String content,
  }) async {
    isLoading.value = true;

    Either<Failure, Message> response = await _messagesRepository.save(
      Message(
        objectId: "messageIdNotSaved",
        userId: profile?.id ?? "",
        from: "me",
        to: "bot",
        textBody: content,
        imageBody: null,
        date: null,
        userDate: date,
      ),
    );
    if (response.isRight()) {
      lastMessage = (response as Right).value;
      messages.add((response as Right).value);
    }
    isLoading.value = false;
  }

  Future _updateMessage(Message updatedMessage) async {
    updatedMessage.id = lastMessage?.id;
    updatedMessage.userDate = lastMessage?.userDate;
    updatedMessage.isViewer = true;

    Either<Failure, Message> response = await _messagesRepository.update(
      updatedMessage,
    );

    if (response.isRight()) {
      lastMessage = (response as Right).value;
      return true;
    }

    return false;
  }

  Future _receiveMessage(dynamic data) async {
    List<Message> messageData;
    if (data is List) {
      messageData =
          (data as List).map((item) => Message.fromChatbot(item)).toList();
    } else {
      messageData = [Message.fromJson(data)];
    }
    Message updatedMessage = messageData.first;
    await _updateMessage(updatedMessage);

    for (var item in messageData) {
      if (item.objectId != updatedMessage.objectId) {
        var response = await _messagesRepository.save(item);
        if (response.isRight()) {
          messages.add(item);
        }
      }
    }
    shouldScrollToBottom.value = true;
    print("SUCCESSO");
  }

  findInitalMessages() async {
    isLoading.value = true;

    final response = await _messagesRepository.findInitial(page: 0, limit: 20);
    if (response.isRight()) {
      messages.assignAll(
        (response as Right).value.reversed.toList(),
      ); // mais antigas por último
    }
    isLoading.value = false;
    shouldScrollToBottom.value = true;
  }

  Future findOlderMessages() async {
    print("🟢 findOlderMessages");
    if (!hasMore.value || isLoading.value || messages.isEmpty) return;

    isLoading.value = true;
    final last = messages.first;

    final response = await _messagesRepository.findOlder(
      lastTimestamp: last.userDate!.millisecondsSinceEpoch,
      lastId: last.id!,
      limit: 3,
    );

    if (response.isRight()) {
      final older = (response as Right).value;
      if (older.isEmpty) {
        hasMore.value = false;
      } else {
        print("✅ findOlderMessages ${older.first}");
        messages.insertAll(0, older.reversed.toList());
      }
    }
    isLoading.value = false;
  }

  Future clickButton({
    required Message message,
    required String content,
  }) async {
    message.isViewer = true;
    Either<Failure, Message> response = await _messagesRepository.update(
      message,
    );
    final index = messages.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      final messageUpdated = messages[index];
      messageUpdated.isViewer = true;
      messages[index] = messageUpdated;
    }
    await _sendAndSaveMessage(content);
  }

  @override
  void onInit() async {
    super.onInit();
    _initializeChat();
  }

  _initializeChat() async {
    await findInitalMessages();
    var isConnected = await _socket.connect();
    if (isConnected) {
      _socket.on("receive-message", _receiveMessage);
    }
  }

  @override
  void onClose() {
    // _socket.disconnect();
    _socket.off("receive-message", _receiveMessage);
    super.onClose();
  }
}

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController(), permanent: true);
  }
}
