import 'package:get/get.dart';
import 'package:tcc_le_app/core/websocket/websocket_service.dart';

class ChatController extends GetxController {
  late final WebSocketService socket;
  // final messages = <Message>[].obs;

  // void sendMessage(String text){
  //   Message data = new Message();
  // }
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
