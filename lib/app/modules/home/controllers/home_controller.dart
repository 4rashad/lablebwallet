import 'package:get/get.dart';
import 'package:lablebwallet/app/data/function_connect.dart';

class HomeController extends GetxController {

final printAssetHolding=Connect().printAssetHolding();
final searchAssetsByName=Connect().searchAssetsByName();
final accountMe=Connect().accountMe();
final algodclient=Connect().algodclient();
void addAssetsMe({required int index})=>Connect().addAssetsMe(indexI: index);
void destroyAssets({required int index})=>Connect().destroyAssets(indexI: index);

  Future<double>  avt(){

   return Connect().algodclient();
 }


}
