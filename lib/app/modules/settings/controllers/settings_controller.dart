import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class SettingsController extends GetxController {



  final box = GetStorage();
  bool get isDark => box.read('darkMode')?? false ;

  void changeMode(bool val) {
    box.write('darkMode', val);
    isDark ? Get.changeThemeMode(ThemeMode.dark) : Get.changeThemeMode(ThemeMode.light);
    update();
  }
}
