import 'package:get/get.dart';
import 'package:lablebwallet/app/modules/home/controllers/home_controller.dart';

import '../controllers/receiver_controller.dart';

class ReceiverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiverController>(
      () => ReceiverController(),
    );
        Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    
  }
}
