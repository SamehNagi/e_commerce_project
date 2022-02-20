import 'package:e_commerce/logic/controllers/cart_controller.dart';
import 'package:e_commerce/logic/controllers/product_controller.dart';
import 'package:get/instance_manager.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.lazyPut(() => CartController());
  }
}
