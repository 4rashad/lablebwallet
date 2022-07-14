import 'package:get/get.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:lablebwallet/main.dart';
class ReceiverController extends GetxController {

  Future<Account> accountMe() async {
    final account =
        await Account.fromSeedPhrase(accountStorage.read("login")!.split(' '));
    return account;
  }

  @override
  void onInit() {
    super.onInit();


  }


}
