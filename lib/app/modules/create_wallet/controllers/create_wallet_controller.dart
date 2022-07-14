import 'package:get/get.dart';
import 'package:algorand_dart/algorand_dart.dart';
import '../../../../main.dart';

class CreateWalletController extends GetxController {
  //TODO: Implement CreateWalletController

  Future<String> createAccountMe() async {
    String phaseMe = "";
    final account = await Account.random();

    List<String> seedPhraseMi = await account.seedPhrase;
    phaseMe = seedPhraseMi.join(" ");
    accountStorage.write("login", phaseMe);
    return phaseMe;
  }
}
