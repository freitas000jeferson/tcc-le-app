import 'package:get/get.dart';
import 'package:tcc_le_app/core/database/tables/message.dart';
import 'package:tcc_le_app/core/domain/message_dto_response.dart';
import 'package:tcc_le_app/core/domain/send_message_dto.dart';
import 'package:tcc_le_app/core/websocket/websocket_service.dart';

class ChatController extends GetxController {
  late final WebSocketService socket;
  final messages = <Message>[].obs;
  RxInt lastMessage = 0.obs;
  RxInt page = 0.obs;

  ChatController() {
    socket = WebSocketService();
    socket.onMessage = receiveMessage;
  }

  RxString text = "".obs;
  void onTextChanged(String value) => text.value = value;

  void sendMessage() async {
    SendMessageDto message = SendMessageDto(message: text.trim());
  }

  receiveMessage(List<MessageDtoResponse> messages) async {}

  findMessages() async {}

  @override
  void onInit() {
    super.onInit();
    socket.connect();
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
