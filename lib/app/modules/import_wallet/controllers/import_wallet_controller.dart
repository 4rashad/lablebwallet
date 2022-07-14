import 'package:get/get.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:lablebwallet/app/routes/app_pages.dart';
import 'package:lablebwallet/main.dart';
class ImportWalletController extends GetxController {
  //TODO: Implement ImportWalletController

String? phaseLogin;
Account? account;
Future<void> loginMe() async {
  try{

   account = await Account.fromSeedPhrase(phaseLogin!.split(' '));
 await accountStorage.write("login",phaseLogin);
  Get.offAndToNamed(Routes.DASHBOARD);
  }
      catch(e){

      }

}








}
