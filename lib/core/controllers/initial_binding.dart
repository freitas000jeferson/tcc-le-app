import 'package:get/get.dart';
import 'package:tcc_le_app/pages/auth/login/controllers/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
  }
}
