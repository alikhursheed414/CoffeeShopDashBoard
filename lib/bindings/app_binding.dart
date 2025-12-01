import 'package:coffee_shop_dashboard/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/base_controller/my_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}