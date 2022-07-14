import 'package:get/get.dart';

import '../controllers/import_wallet_controller.dart';

class ImportWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImportWalletController>(
      () => ImportWalletController(),
    );
  }
}
