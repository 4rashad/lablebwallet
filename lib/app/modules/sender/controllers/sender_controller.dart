
import 'package:get/get.dart';
import 'package:lablebwallet/app/data/function_connect.dart';

class SenderController extends GetxController {
  var buttonEnable=false.obs;
var txId="".obs;
Future<String> sender({required String address, required double amount}) => Connect().sender(address: address, amount: amount);




}
