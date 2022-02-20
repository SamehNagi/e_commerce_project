import 'package:get/instance_manager.dart';
import 'package:e_commerce/logic/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
