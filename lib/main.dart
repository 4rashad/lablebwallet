import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/home_style.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/routes/app_pages.dart';

GetStorage accountStorage=GetStorage();
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final controller=Get.put<SettingsController>(SettingsController());
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: controller.isDark?ThemeMode.dark:ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.fadeIn,
      getPages: AppPages.routes,
    ),
  );
}
/*
final box = GetStorage();
bool get isDark => box.read('darkMode')?? false ;

void changeMode(bool val) {
  box.write('darkMode', val);
  isDark ? Get.changeThemeMode(ThemeMode.dark) : Get.changeThemeMode(ThemeMode.light);
  update();
}*/