import 'package:get/get.dart';
import 'package:lablebwallet/app/modules/home/controllers/home_controller.dart';

import '../controllers/sender_controller.dart';

class SenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SenderController>(
      () => SenderController(),
    );

    Get.lazyPut<HomeController>(
          () => HomeController(),
    );


  }




}
